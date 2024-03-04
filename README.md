# cell_count_demo
Demonstration of cell counting. Comparing different methods.

## Necessary packages
- numpy, pandas, tqdm, cv2(opencv), matplotlib, seaborn, cellpose
- All packages except cellpose are quite common and easy to install.
- For cellpose, if you are already in the desired virtual environment to use, run `python -m pip install cellpose` should work properly. If any troubles, please refer to the [official site instructions](https://github.com/MouseLand/cellpose?tab=readme-ov-file#installation)

## Data and output directory structure
As written in the notebook, please download and extract the zipped dataset and locate them under the project root. With that you should have the data directory structure as follows.
```bash
cell_count_demo (prject root)
  |- imgs
    |- DAPI
      |- emetine
        |- 0.1
        |- ...
      |- etosposide
        |- ...      
      |- staurosporine
        |- ...
```

Also, please make the empty output directory as follows. There will be more directories inside, but they will be created by the script.
```bash
cell_count_demo (prject root)
  |- outs
    |- single
    |- otsu
```

<br><br>

All good? Then please go to `cell_count_demo.ipynb` to see the demonstration.

