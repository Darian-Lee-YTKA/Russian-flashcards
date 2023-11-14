<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="13142" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
    <dependencies>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="12042"/>
    </dependencies>
    <objects>
        <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner"/>
        <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
    </objects>
</document>

from transformers import MarianMTModel, MarianTokenizer
#


ruToEn_model = MarianMTModel.from_pretrained("Helsinki-NLP/opus-mt-ru-en")
tokenizerRuToEn = MarianTokenizer.from_pretrained("Helsinki-NLP/opus-mt-ru-en")
enToRu_model = MarianMTModel.from_pretrained("Helsinki-NLP/opus-mt-en-ru")
tokenizerEnToRu = MarianTokenizer.from_pretrained("Helsinki-NLP/opus-mt-en-ru")

russian_alphabet = {
    "а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н",
    "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я"
}

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
