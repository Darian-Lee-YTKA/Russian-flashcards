from fastapi import FastAPI, HTTPException
from flask import Flask, request, jsonify
from transformers import MarianMTModel, MarianTokenizer

app = Flask(__name__)

ruToEn_model = MarianMTModel.from_pretrained("Helsinki-NLP/opus-mt-ru-en")
tokenizerRuToEn = MarianTokenizer.from_pretrained("Helsinki-NLP/opus-mt-ru-en")
enToRu_model = MarianMTModel.from_pretrained("Helsinki-NLP/opus-mt-en-ru")
tokenizerEnToRu = MarianTokenizer.from_pretrained("Helsinki-NLP/opus-mt-en-ru")

russian_alphabet = {
    "а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н",
    "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я"
}

@app.route('/translate', methods=['POST'])
def translate():
    data = request.get_json()

    if 'text' not in data:
        return jsonify({'error': 'Missing "text" parameter'}), 400

    text = data['text']
    result = translate_text(text)
    return jsonify({'translation': result})

def translate_text(text: str):
    text_set = set(list(text))

    if len(text_set.intersection(russian_alphabet)) != 0:
        language = "ru"
    else:
        language = "en"

    if language == "ru":
        model = ruToEn_model
        tokenizer = tokenizerRuToEn
    else:
        model = enToRu_model
        tokenizer = tokenizerEnToRu

    inputs = tokenizer(text, return_tensors="pt")
    translation = model.generate(**inputs)
    translated_text = tokenizer.batch_decode(translation, skip_special_tokens=True)

    result = translated_text[0]
    return result

if __name__ == '__main__':
    app.run(debug=True)

