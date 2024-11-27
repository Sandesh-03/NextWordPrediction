# 📝 Text Prediction Application with N-Gram Algorithm

![Flutter](https://img.shields.io/badge/Flutter-Framework-blue?logo=flutter&style=flat-square)
![Python](https://img.shields.io/badge/Python-Backend-yellow?logo=python&style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

This repository contains a Text Prediction Application implemented using Flutter for the front end and Python Flask APIs for the backend services. The application uses an N-Gram Language Model for word prediction and supports multilingual functionality, including English and Marathi.

---

## 📜 Description

The Text Prediction Application allows users to:
- 🖊 Predict the next word based on user input using the **N-Gram algorithm**.
- 🧠 Explore two prediction approaches:
  - A **default N-Gram model**.
  - A model utilizing **Recurrent Neural Networks (RNNs)**.
- 🌍 Toggle between supported languages for prediction.
- 🎨 Enjoy a clean and user-friendly interface built with Flutter.

The backend APIs leverage Python's **Flask framework** to compute predictions efficiently and accurately.

---

## 🔍 N-Gram Algorithm

### What is an N-Gram?
An **N-Gram** is a sequence of `n` items (words, characters, etc.) extracted from a given text. For example:
- **Unigram**: "I"
- **Bigram**: "I am"
- **Trigram**: "I am learning"

In this application:
- **Bigrams (n=2)** are primarily used.
- The model predicts the next word based on the frequency of word pairs in the input dataset.

### How It Works
1. **Data Preparation**: The input text is tokenized into sequences.
2. **Probability Calculation**:
   - For a context (e.g., previous words), the probability of the next word is calculated as:
     
     `P(next_word | context) = Count(context + next_word) / Count(context)`
    
3. **Word Selection**: The word with the highest probability is chosen as the predicted word.

Even with a relatively small dataset, the N-Gram model ensures lightweight and high-speed predictions.

---
## 🚀 Running Steps

### 🛠 Backend Setup
   1. **Clone the repository:**
      ```
      git clone https://github.com/Sandesh-03/NextWordPrediction.git
      cd NextWordPrediction
      
      ```
  2. **Navigate to the server directory:**
      ```
      cd server
    
      ```
  3. **Install the required Python dependencies:**
      ```
     pip install -r requirements.txt
      
      ```
  4. **Start the Flask server:**
      ```
      python api.py
      
      ```
 The server will start running at http://127.0.0.1:5001.
 
 ----
 
### 📱 Frontend Setup
 
   1. **Ensure you have Flutter installed. If not, follow the [Flutter installation guide.](https://docs.flutter.dev/get-started/install)**
   2. **Navigate to the Flutter project directory:**
      ```
      cd NextWordPrediction

      ```
       
   4. **Install the required Flutter dependencies:**
        ```
         flutter pub get
  
        ```
   5. **Run the app on your desired platform (emulator, simulator, or device):**
        ```
        flutter run
        
        ```
---

## 📂 Project Structure

  ```
  root
  ├── lib/                # Flutter application code
  │   ├── main.dart       # Main entry point
  │   ├── splashScreen.dart
  │   ├── rnn.dart        # RNN-based prediction screen
  │   ├── text_prediction.dart
  │   └── localeString.dart # Language support
  ├── server/             # Backend server code
  │   ├── api.py          # N-Gram prediction API
  │   ├── rnn/            # RNN model files
  ├── pubspec.yaml        # Flutter dependencies
  ├── requirements.txt    # Python dependencies
  
  ```


---

## ✨ Features

- 🌐 Multilingual Support: English and Marathi predictions are supported.
- 🧠 Prediction Models:
  - N-Gram-based predictions for lightweight, efficient processing.
  - RNN-based predictions for deeper language understanding.
- 🎨 Interactive UI: Flutter-powered interface for seamless user experience.




   
