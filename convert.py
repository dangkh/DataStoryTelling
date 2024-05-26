import os
import pandas as pd
path = "./data"
names = os.listdir(path)
print(names)
tmp = []
allPd = []
for name in names:
	idS, ext = name.split('.')
	if ext != "pkl":
		continue
	tmp.append(idS)
	stock = os.path.join(path, name)
	df = pd.read_pickle(stock)
	df = df[-700:] 
	file_csv = idS+'.csv'
	listName = [idS]*len(df)
	df.insert(2, "Name", listName)
	allPd.append(df)
	df.to_csv(os.path.join(path, file_csv))
allPd = pd.concat(allPd)
allPd.to_csv(os.path.join(path, "all.csv"))
print(tmp)