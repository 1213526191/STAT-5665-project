# STAT-5665-project

|Author|Yifan Li.           |
|------|--------------------|
|E-mail|yifan.3.li@uconn.edu|

- report.pdf: final report
- code: 
	- clean\_data.ipynb: do data cleaning in **2.1 Clean Data** to create *random100000.csv* in data file
	- create\_variable.R: use *random100000.csv* to calculate variable Score1 to Score5 in **2.2 Determine Positive and Negative Words** and create *pos_neg.csv* in data file
	- pos\_neg.R: use *pos_neg.csv* and *random100000.csv* to calculate variables S1 to S5 in **2.3 Determine Positive and Negative Reviews** and create *data_final.csv* in data file
	- LM.R: use *data_final.csv* to fit the linear model in **3 LSTM Model**
	- LSTM.ipynb: use *data_final.csv* to fit the LSTM network in **3 LSTM Model**
- data: original data is too large to upload. So I provide data after cleaning--*random100000.csv*. Other data are created while coding.
- image: Figure 1 and Figure 2 in *report.pdf*
- project_final: latex file
	