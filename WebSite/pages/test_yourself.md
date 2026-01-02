# SE 3509 Introduction to Data Science & Engineering
## Test Yourself Final

**Use pima.tr and pima.te dataset from the library(MASS)**

A population of female adults who were at least 21 years old, of Pima Indian heritage and living near Phoenix, Arizona, was tested for diabetes according to World Health Organization criteria. The data were collected by the US National Institute of Diabetes and Digestive and Kidney Diseases.

`pima.tr` (training) and `pima.te` (test) are data frames which have 8 columns (attributes+response). Use these datasets to create models to classify diabetes.

The variables are:
*   `npreg` (number of pregnancies)
*   `glu` (plasma glucose concentration)
*   `bp` (diastolic blood pressure)
*   `skin` (triceps skin fold thickness)
*   `bmi` (body mass index)
*   `ped` (diabetes pedigree function)
*   `age` (age in years)
*   `type` (Yes or No, for diabetic according to WHO criteria).

---

### Questions

1.  **Missing Values check:** Check whether the datasets includes any missing values. 0’s are missing for the variables except for npreg and type. NA’s are missing for all variables.

2.  **Symmetric Distribution:** Explore the attributes and write down the ones that have symmetric distribution using the training dataset.

3.  **Feature Plot:** Create a feature plot and evaluate the attributes that best classify the response using the training dataset.

4.  **Cross Validation:** Create a cross validation object for 10 fold CV with 5 replicates.

5.  **Model Training:** Train logistic regression and random forest models using centered and scaled predictors.

6.  **Model Evaluation:** Create confusion matrices where the positive class is “Yes”. Write down the accuracy, sensitivity and specificity scores for each model. Which one would you prefer?

7.  **Prediction:** Suppose two patients come with the following measurements. What would be the predicted classes for these two patients?
    ```
              npreg glu   bp   skin  bmi    ped      age
    patient#1 4     148   72   35    24.6   0.627    40
    patient#2 1     85    66   29    26.6   0.351    17
    ```

8.  **PCA:** Perform a Principal Component Analysis on the 7 numerical predictors of the Pima.tr dataset. Summarize the PCs and explain the cumulative variance contribution of the first 3 PCs.

9.  **Scale Necessity:** Explain the statistical necessity of the `scale = TRUE` argument in the context of the Pima dataset variables (e.g., glu, bmi, ped). What would be the likely impact on the Principal Component Loadings if this argument were set to FALSE?

10. **Scree Plot:** Produce a Scree Plot of the variances. Define the Elbow Method.

11. **PCA Interpretation:** The output for the first Principal Component (PC1) shows high positive rotation values (loadings) for age, npreg (number of pregnancies), and glu (glucose).
    *   (a) How should a researcher interpret a patient who has a high negative score on PC1?
    *   (b) Is it mathematically possible for age and glu to be negatively correlated if they both have high positive loadings on PC1? Explain your reasoning.

12. **PCA in Regression:** Instead of using the 7 original variables, you decide to use the scores of the first 3 Principal Components as predictors in a Logistic Regression.
    *   (a) Discuss one major advantage of this approach regarding multicollinearity.
    *   (b) Discuss the "cost" of this approach in terms of clinical interpretability for a doctor using the model to diagnose a patient.

13. **Regression Assumptions:** You are investigating the factors that contribute to Body Mass Index (BMI) in the Pima population. You decide to build a multiple linear regression model using the Pima.tr dataset.
    *   (a) Describe how you would use a Residuals vs. Fitted plot to check for Homoscedasticity. What pattern in the dots would indicate a violation of this assumption?
    *   (b) If the Normal Q-Q plot shows the points curving significantly away from the diagonal line at the ends, what does this suggest about your model's residuals?

14. **Interpretation of Estimates:** Suppose the output for the skin (skinfold thickness) variable is as follows:
    `Estimate: 0.395 | Std. Error: 0.045 | t value: 8.77 | Pr(>|t|): < 2e-16`
    *   (a) Provide a formal interpretation of the Estimate (0.395). What happens to the predicted BMI for every 1-unit increase in skinfold thickness, assuming all other variables remain constant?
    *   (b) Is the skin variable a statistically significant predictor of BMI at the α= 0.05 level? Justify your answer using the provided p-value.

15. **Multicollinearity:** In this dataset, skin and bmi are both measures related to body fat, and age is often related to npreg. Define Multicollinearity. Why might it be a problem to include both skin and bp (blood pressure) if they were highly correlated?

16. **R-squared:** The model summary provides both Multiple R-squared and Adjusted R-squared.
    *   (a) Calculate Multiple R-squared. What does this value tell you about the relationship between your predictors and BMI?
    *   (b) Why is it generally safer to rely on the Adjusted R-squared when comparing this model to a larger model that includes more predictors?

17. **Stepwise Regression:** You have a "Full Model" that uses all 7 predictors to explain bmi. However, you suspect some variables are redundant. You decide to perform a Backward Stepwise Regression in R using the step() function. How would you evaluate this model?

18. **Reduced Model:** After the stepwise process finishes, you are left with a reduced_model.
    *   (a) Will the Multiple R-squared of the reduced_model be higher, lower, or equal to the full_model?
    *   (b) Why might a researcher prefer the reduced_model even if it explains slightly less variance than the full_model?

19. **Stepwise Criticism:** Stepwise regression is a "greedy" algorithm. Discuss one potential risk or criticism of relying solely on automated stepwise selection for clinical data like the Pima study.

20. **Mice Package (m=5):** You are using mice package for missing data imputation.
    *   (a) What does the number m=5 represent in this context?
    *   (b) Why is it better to create multiple imputed datasets (m > 1) rather than just one "perfect" imputed dataset?

21. **Missing Data Types:** The effectiveness of the mice package depends on why the data is missing. Define the following three terms and identify which one is the most difficult for the mice package to handle:
    *   MCAR (Missing Completely at Random)
    *   MAR (Missing at Random)
    *   MNAR (Missing Not at Random)
    *   Example: If patients with very high blood pressure were intentionally skipping the BP test because they felt unwell, which of the three categories above would this fall into?

22. **Pooling:** Mice package provides pooling as a function.
    *   (a) Why can't you just run lm() on a single imputed dataset?
    *   (b) What is the purpose of the pool() function? What does it do to the standard errors of your coefficients to account for the fact that the data was originally missing?
