
from flask import Flask, jsonify, request
from collections import Counter
from flask_cors import CORS  

app = Flask(__name__)
CORS(app)  

ngram_counts = Counter()

def create_ngrams(training_data, n):
    ngrams = []
    for sentence in training_data:
        tokens = sentence.split()
        tokens = [token.lower() for token in tokens if token.isalpha() and not token.isdigit()]  
        tokens.insert(0, "<s>")
        tokens.append("</s>")
        for i in range(len(tokens) - n + 1):
            ngrams.append(tuple(tokens[i:i+n]))
    return ngrams

def calculate_probability(prev_words, current_word):
    ngram = prev_words + (current_word,)
    count_ngram = ngram_counts[ngram]
    count_prev_words = sum(count for _, count in ngram_counts.items() if _[:-1] == prev_words)
    probability = count_ngram / count_prev_words if count_prev_words > 0 else 0
    return probability

def predict_next_word(sequence):
    words = sequence.split()
    words = [word.lower() for word in words if word.isalpha() and not word.isdigit()]  
    prev_words = tuple(words[-1:]) if len(words) >= 1 else ()
    candidates = [word[-1] for word in ngram_counts if isinstance(word[-1], str) and word[:-1] == prev_words and word[-1].isalpha() and not word[-1].isdigit()]
    next_word = max(candidates, key=lambda word: calculate_probability(prev_words, word), default=None)
    return next_word or "" 

@app.route('/predict_next_word_route' , methods=['POST'])
def predict_next_word_route():
    data = request.json
    training_data = data.get('training_data', [])
    last_sentence = training_data[-1]  
    last_words = last_sentence.split()[-2:]  
    global ngram_counts
    ngrams = create_ngrams(training_data, 2)
    ngram_counts = Counter(ngrams)

    input_sequence = " ".join(last_words)  
    predicted_word = predict_next_word(input_sequence)
    print(f"The predicted next word for '{input_sequence}' is '{predicted_word}'")
    return jsonify({'predicted_word': predicted_word})  

if __name__ == "__main__":
    app.run(debug=True)