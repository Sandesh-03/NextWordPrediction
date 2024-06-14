from flask import Flask, request, jsonify
import numpy as np
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

with open('../data2.txt', 'r') as f:
    data = f.read()

words = data.split()
word_to_ix = {word: i for i, word in enumerate(words)}
ix_to_word = {i: word for i, word in enumerate(words)}

hidden_size = 100
seq_length = 3
learning_rate = 1e-2

Wxh = np.random.randn(hidden_size, len(words)) * 0.01  
Whh = np.random.randn(hidden_size, hidden_size) * 0.01  
Why = np.random.randn(len(words), hidden_size) * 0.01  
bh = np.zeros((hidden_size, 1)) 
by = np.zeros((len(words), 1))  
def lossFun(inputs, targets, hprev):
    xs, hs, ys, ps = {}, {}, {}, {}
    hs[-1] = np.copy(hprev)
    loss = 0

    for t in range(len(inputs)):
        xs[t] = np.zeros((len(words), 1))
        xs[t][inputs[t]] = 1  
        hs[t] = np.tanh(np.dot(Wxh, xs[t]) + np.dot(Whh, hs[t - 1]) + bh)  
        ys[t] = np.dot(Why, hs[t]) + by 
        ps[t] = np.exp(ys[t]) / np.sum(np.exp(ys[t]))  
        loss += -np.log(ps[t][targets[t], 0])  

    # Backward pass
    dWxh, dWhh, dWhy = np.zeros_like(Wxh), np.zeros_like(Whh), np.zeros_like(Why)
    dbh, dby = np.zeros_like(bh), np.zeros_like(by)
    dhnext = np.zeros_like(hs[0])

    for t in reversed(range(len(inputs))):
        dy = np.copy(ps[t])
        dy[targets[t]] -= 1  
        dWhy += np.dot(dy, hs[t].T)
        dby += dy
        dh = np.dot(Why.T, dy) + dhnext  
        dhraw = (1 - hs[t] * hs[t]) * dh  
        dbh += dhraw
        dWxh += np.dot(dhraw, xs[t].T)
        dWhh += np.dot(dhraw, hs[t - 1].T)
        dhnext = np.dot(Whh.T, dhraw)

    for dparam in [dWxh, dWhh, dWhy, dbh, dby]:
        np.clip(dparam, -5, 5, out=dparam)  

    return loss, dWxh, dWhh, dWhy, dbh, dby, hs[len(inputs) - 1]
def sample(h, seed_ix, n):
    x = np.zeros((len(words), 1))
    x[seed_ix] = 1
    ixes = [seed_ix]
    for t in range(n):
        h = np.tanh(np.dot(Wxh, x) + np.dot(Whh, h) + bh)
        y = np.dot(Why, h) + by
        p = np.exp(y) / np.sum(np.exp(y))
        ix = np.random.choice(range(len(words)), p=p.ravel())
        x = np.zeros((len(words), 1))
        x[ix] = 1
        ixes.append(ix)
    return ixes

@app.route('/generate_text', methods=['POST'])
def generate_text():
    data = request.get_json()
    seed_text = data.get('seed_text', '')
    num_words = data.get('num_words', 3)

    seed_ix = [word_to_ix.get(word, 0) for word in seed_text.split()]
    h = np.zeros((hidden_size, 1))

    sample_ix = sample(h, seed_ix[-1], num_words)
    generated_text = ' '.join(ix_to_word[ix] for ix in sample_ix)

    return jsonify({'generated_text': generated_text})

if __name__ == '__main__':
    app.run(debug=True)