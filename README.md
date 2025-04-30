
### Stripped down version of FedMultiomodal to reproduce the improved results for CRISIS-MMD Dataset for FedMultimodal+ (Image and Text)

### Installation

To install the conda environment:
```
cd FedMultimodal-
conda create --name fed-multimodal+ python=3.9
conda activate fed-multimodal+
```

Then pip install the package:
```
pip install -e .
```

#### 1. Download data: The data will be under data/crisis-mmd by default. 

You can modify the data path in system.cfg to the desired path.

```
cd data
bash download_crisismmd.sh
cd ..
```

Data will be under data/crisis-mmd

#### 2. Partition the data

We partition the data using direchlet distribution.

```
# Low data heterogeneity
python3 features/data_partitioning/crisis-mmd/data_partition.py --alpha 5.0

# High data heterogeneity
python3 features/data_partitioning/crisis-mmd/data_partition.py --alpha 0.1
```

The return data is a list, each item containing [key, img_file, label, text_data], e.g.:

```
[
    "920300145253613569_0",
    "/home/tiantiaf/fed-multimodal/fed_multimodal/data/crisis-mmd/CrisisMMD_v2.0/data_image/california_wildfires/17_10_2017/920300145253613569_0.jpg",
    0,
    "Teams, players send young fan new memorabilia to replace collection lost in California fire"
],
```

#### 3. Feature extraction

For Crisis-MMD dataset, the feature extraction includes text/visual feature extraction.

```
# extract efficientnet_b0 feature
python3 features/feature_processing/crisis-mmd/extract_img_feature.py --feature_type efficientnet_b0 --alpha 5.0
python3 features/feature_processing/crisis-mmd/extract_img_feature.py --feature_type efficientnet_b0 --alpha 0.1

# extract distilbert feature
python3 features/feature_processing/crisis-mmd/extract_text_feature.py --feature_type distilbert --alpha 5.0
python3 features/feature_processing/crisis-mmd/extract_text_feature.py --feature_type distilbert --alpha 0.1
```

#### 4. (Optional) Simulate missing modality conditions

default missing modality simulation returns missing modality at 10%, 20%, 30%, 40%, 50%

```
cd features/simulation_features/crisis-mmd
# output/mm/crisis-mmd/{client_id}_{mm_rate}.json

# missing modalities
bash run_mm.sh
cd ../../../
```
The return data is a list, each item containing:
[missing_modalityA, missing_modalityB, new_label, missing_label]

missing_modalityA and missing_modalityB indicates the flag of missing modality, new_label indicates erroneous label, and missing label indicates if the label is missing for a data.

#### 5. Run base experiments (FedAvg, FedOpt, FedProx, ...)
```
cd experiment/crisis-mmd
bash run_base.sh
```


