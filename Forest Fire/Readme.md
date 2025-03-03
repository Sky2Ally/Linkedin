# 🔥 Predicting Forest Fire Impact: Classification & Regression Models

## 📌 Project Overview
This project focuses on predicting the impact of forest fires using machine learning models. The models leverage weather data and fire indicators to classify fire severity and estimate the burned area. 

### 🔍 Business Objective
- **Classification Models:** Categorize fire severity (No Damage, Low, Moderate, High, Very High) to optimize resource allocation and reduce response time.
- **Regression Models:** Predict the burned area to improve emergency planning and response strategies.
- **Key Performance Indicators (KPIs):**
  - Reduce reaction time by identifying high-risk scenarios early.
  - Optimize resource allocation based on fire intensity predictions.
  - Minimize fire damage through proactive forest management.

---
## 📊 Data & Features
- **Key Predictors:** Temperature, Relative Humidity (RH), Drought Code (DC), Initial Spread Index (ISI), and their interactions.
- **Feature Engineering:** Interaction terms were created to improve model performance.
- **Target Variables:**
  - **Classification:** Burn severity levels.
  - **Regression:** Log-transformed burned area (area_log).

---
## 📊 Model Performance Comparison
| Model                     | Accuracy | Kappa  | Precision | Recall | F1 Score |
|---------------------------|----------|--------|-----------|--------|----------|
| Decision Tree             | 0.4211   | 0.0484 | 0.1800    | -      | -        |
| Random Forest            | 0.2203   | 0.4803 | 0.0042    | 0.0967 | 0.1920   |
| Support Vector Machine   | 0.2000   | 0.4803 | 0.0042    | 0.0967 | 0.1304   |
| k-Nearest Neighbors (kNN) | 0.2000   | 0.4408 | 0.0812    | 0.2011 | 0.1304   |
| Artificial Neural Network | 0.4474   | 0.2285 | 0.0611    | 0.2480 | **0.2127** |

### 🏆 Best Performing Model
The **Artificial Neural Network (ANN)** achieved the highest accuracy (0.4474) and the best F1 Score (0.2127), making it the most effective in balancing precision and recall.

### ❌ Least Performing Models
The **Random Forest and Support Vector Machine (SVM)** performed the worst, with a low Kappa (0.0042) and Precision (0.0967), indicating poor classification capability.

## 📌 Key Findings
- The ANN model showed the best balance between true positives and false positives, making it the most reliable model.
- Decision Tree had moderate accuracy but was outperformed by ANN.
- Random Forest and SVM struggled to classify the data effectively.
- Weather data plays a crucial role in predicting fire spread and severity.

## 🔧 Future Enhancements
- Improve feature selection to enhance model performance.
- Experiment with ensemble learning techniques for better classification.
- Integrate real-time fire data for dynamic predictions.
- Deploy the model using a web-based dashboard for real-time insights.
---
## 📂 Repository Structure
```
├── data/              # Raw & processed data files
├── models/            # Trained ML models & hyperparameter tuning
├── notebooks/         # Jupyter notebooks with EDA & model training
├── src/               # Scripts for data preprocessing & modeling
├── results/           # Evaluation reports & visualizations
└── README.md          # Project overview & documentation
```

---
## 📌 Future Enhancements
✅ Improve feature engineering with interaction terms.  
✅ Experiment with deep learning models (e.g., LSTMs for time-series analysis).  
✅ Fine-tune hyperparameters for improved classification accuracy.  
✅ Apply advanced ensemble methods to enhance prediction robustness.

---
## 📢 Acknowledgments
This project is part of my **Bachelor of Computer Science (Data Science) at Swinburne University of Technology**. The models were developed following best practices in machine learning and data analysis.

📧 **Let's Connect!** [LinkedIn](https://www.linkedin.com/in/bhuvan-virmani-5510a8219/)  
🌟 **Star this repo if you found it useful!** ⭐
