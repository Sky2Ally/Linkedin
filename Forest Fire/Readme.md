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
## 🚀 Models Implemented
### 🔢 **Classification Models**
| Model | Key Findings |
|--------|------------------------------------------------|
| **Decision Tree** | 25 terminal nodes, RH and DC were key predictors. |
| **Random Forest** | 500 trees; temp & RH interaction had the highest importance. |
| **Support Vector Machine (SVM)** | Optimal C=1, but accuracy was 49% with low class separability. |
| **k-Nearest Neighbors (kNN)** | k=9 performed the best with moderate accuracy. |
| **Artificial Neural Network (ANN)** | 5 neurons in a hidden layer, trained for 500 iterations. |

### 📈 **Regression Models**
| Model | RMSE | MAE | R² |
|--------|------|------|------|
| **Decision Tree Regression** | 0.217 | 0.172 | 0.00035 (Underfitting) |
| **Random Forest Regression** | TBD | TBD | TBD |
| **Linear Regression** | TBD | TBD | TBD |

- **Decision Tree Regression:** High error, underfitting, and poor generalization.
- **Random Forest Regression & Linear Regression:** Performance metrics to be updated.

---
## 📌 Key Findings & Insights
- **Decision Trees identified December, RH, and DC as strong predictors.**
- **Random Forest outperformed other classifiers with stable predictions.**
- **SVM and kNN showed lower accuracy due to high variability in fire spread.**
- **Regression models struggled with generalization, highlighting non-linearity in fire spread.**

---
## 🛠️ Tech Stack
- **Programming Language:** R
- **Libraries Used:** rpart, caret, nnet, randomForest
- **Evaluation Metrics:** RMSE, MAE, R², Gini Impurity

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
