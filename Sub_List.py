import pandas as pd
import requests
from tabula import read_pdf
import numpy as np
import sys


def get_list(url = 'https://www.mynavyhr.navy.mil/Portals/55/Career/Detailing/Officer/SubmarineNuclear/Career/DHDetailing/DH%20Billets%20for%20Website%2022DEC21.pdf?ver=OgEkwGCsw4ERTIwkzpuW-A%3d%3d'):
    # Takes one argument: url. Returns .csv of submarine options.

    # Retrieve .pdf of submarine list
    r = requests.get(url, allow_redirects=True)
    open('Sublist.pdf', 'wb').write(r.content)
    df = read_pdf('Sublist.pdf', pages = 'all')

    # Populate, clean, and save .csv file
    working = []
    col_names = [df[0].columns]
    for item in range(0,len(df)):
      df[item] = pd.DataFrame(np.vstack([df[item].columns, df[item]]))
      working.append(df[item])
    out = pd.concat(working)
    out.columns = col_names
    out = out.drop(index = 0)
    out = out.reset_index()
    out = out.drop('index', axis = 1)
    out.to_csv('Sublist.csv', index = False)

if __name__ == '__main__':
    get_list()
