### *Analysis code accompanying the manuscript entitled*

# Meta-analytic evidence for distinct neural correlates of conditioned vs. verbally induced placebo analgesia
### *by Tamas Spisak, Helena Hartmann, Matthias Zunhammer, Balint Kincses, Katja Wiech, Tor Wager, & Ulrike Bingel, for the [Placebo Imaging Consortium](https://placebo-imaging-consortium.github.io/)*

### 📃 Abstract

Placebo analgesia demonstrates that belief and expectation can significantly alter pain, even without active treatment. Placebo analgesia can be induced through verbal suggestion, classical conditioning, or their combination, though the role of conditioned neural responses above and beyond effects of verbal instructions remains unclear. We conducted a systematic meta-analysis of individual participant data from 16 within-participant placebo neuroimaging studies (n = 409), employing univariate and multivariate analyses to identify shared and distinct mechanisms of placebo analgesia induced by suggestions alone versus suggestions combined with conditioning. Both techniques increased activity during pain in the dorsolateral prefrontal and inferior parietal cortices and decreased activation in the insula, putamen, and primary sensory areas. Adding conditioning enhanced engagement of regions associated with context representation and pain modulation (e.g., dorsolateral/dorsomedial prefrontal cortices) and decreases in nociceptive regions (e.g., primary sensory and insular areas). Conditioning also strengthened the association between analgesia and nociceptive activity, as reflected in the Neurologic Pain Signature. Combining conditioning with instructions yielded greater analgesia, mediated by increased ventromedial prefrontal and dorsal caudate activity, alongside decreased sensory-nociceptive and cerebellar activity. These findings suggest the two strategies rely on partially distinct mechanisms, which could be combined to optimize placebo analgesia’s clinical application.

### 📄 Preprint
https://www.biorxiv.org/cgi/content/short/2025.05.21.655287v1

### 📁 Repository contents

The repository assumes the presence of a `data` directory, that containes preprocessed 1st level neuroimaging and behavioral/penotypic data. This is not directly supplied on github. To get access, contact the [Placebo Imaging Consortium](https://placebo-imaging-consortium.github.io/).

```
.
├── get_data              : matlab scripts to extract preprocessed data from our previous analysis: https://github.com/mzunhammer/PlaceboImagingMetaAnalysis (Zunhammer et al., 2018, 2021)
├── behavior              : python notebooks to analyze behavioral data
├── imaging               : python notebooks implementaing the main mediation analysis, presented in the paper
├── plot                  : python notebooks used for generating the figures and tables
├── resources             : figure source files (svg)
├── LICENSE               : MIT License (for all source code, but excluding material not contained in this repository: data, manuscript, final figures )
├── requirements.txt      : required python packages 
└── README.md             : the file you read now.
```

Recommended Python version: 🐍 3.9.6

### ➡️ See also

- Placebo Imaging Consortium website: https://placebo-imaging-consortium.github.io/
- Other publications from the placebo meta-analysis dataset:
    - Zunhammer et al. Placebo Effects on the Neurologic Pain Signature: A Meta-analysis of Individual Participant Functional Magnetic Resonance Imaging Data, 2018, JAMA Neurology, DOI: https://doi.org/10.1001/jamaneurol.2018.2017
    - Zunhammer et al. Meta-analysis of neural systems underlying placebo analgesia from individual participant fMRI data, 2021, Nature Communications, DOI: https://doi.org/10.1038/s41467-021-21179-3
- Source code of previous analyses: https://github.com/mzunhammer/PlaceboImagingMetaAnalysis 
