%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load data.frame to use
% Suggested: Datasets/data_frame.mat
disp('* Load data frame')
projectpath='/home/analyser/Dropbox/Boulder_Essen';
load(strcat( projectpath,'/Datasets/data_frame.mat'));

disp('* Collect all data...')

table=extract_data_frame(df);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analyse multicollinearity for full dataset
disp('* Analyse multicollinearity...')

% create design withpout dummy coding... (not perfect)
% 1: center (nominal idx, should be dummy encoding)
% 2: Male (numeric?)
% 3: Age (numeric)
% 4: NPS_pain_ctr (numeric)
% 5: Rating_diff (numeric)
% 6: Conditioning (nominal binary, encoded as -1:suggestion, 1:suggestion+conditioning)
% 7: TR (numeric)
% 8: TE (numeric)
% 9: FWHM (numeric)
% 10: Stim_Type (nominal idx, should be dummy encoding)
% 11: Stim_Dur (numeric)
% 12: Stim_Side (nominal idx, should be dummy encoding)
% 13: Stim_Loc (nominal idx, should be dummy encoding)

%design_matrix_all=[dummyvar(nominal(table{:,1})), table{:,[3:6]}-mean(table{:,[3:6]}, 'omitnan'), grp2idx(nominal(table{:,7}))*2-3]
design_matrix_vif=[grp2idx(nominal(table{:,1})), table{:,[3:6]}, grp2idx(nominal(table{:,7})), table{:,[8:10]}, grp2idx(nominal(table{:,11})), table{:,[12]}, grp2idx(nominal(table{:,13})), grp2idx(nominal(table{:,14}))]; 

vif(demean(mean_inputting(design_matrix_vif)))
% res:
% 2.3583    1.2534    1.5001    1.3251    1.0884    2.1756    4.0410    2.9885    1.9998    8.1244    4.8176    3.4499    9.8008
% that is: no collinearity for the variable(s) of interest (conditioning, and condition x Rating_diff)
% Stim_Loc and Stim_Type are collinear, though
% TR and Stim_Dur might be slightly collinear, but well below the rule-of-thumb threshold


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create simplified design matrix with study modelling
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('* Create design matrix with interaction...')

% exclude rows with any NaN
table_nonan=table(~any(ismissing(table),2),:);

% columns: 1-16: center (nominal(16), "cell-mean" dummy encoding, inplements the intercept)
% it's also the variance groups
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 17: Rating_diff (numeric)
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Confounders
% 18: Male (numeric?)
% 19: Age (numeric)
design_matrix=[dummyvar(nominal(table_nonan.Study_ID)), demean(table_nonan.Rating_diff), demean(table_nonan.Male), demean(table_nonan.Age))    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create contrast

contrast=[]

studies=unique(table_nonan.Study_ID)

for study = 1:length(studies)
    a=table_nonan.Conditioning(strcmp(table_nonan.Study_ID,studies{study}));
    if strcmp(a{1,1}, 'suggestions') % this is the ref
        contrast(1,study)=-1
        contrast(2,study)=1
    elseif strcmp(a{1,1}, 'suggestions & conditioning')
        contrast(1,study)=1
        contrast(2,study)=-1
    end
end

% plus three zeros for Rating_diff, Male and Age
contrast(2,length(contrast)+3)=0

%plus add contrasts for the rating_diff, male and age, just for fun
contrast(3,length(studies)+1)=1
contrast(3,length(studies)+1)=-1
contrast(4,length(studies)+2)=1
contrast(4,length(studies)+2)=-1
contrast(5,length(studies)+3)=1
contrast(5,length(studies)+3)=-1


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create 4D input file in command line:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('* Create 4D input file...')
% adjust datapath
DATAPATH=strcat( projectpath,'/Analysis/G_meta_analysis_whole_brain/GIV/nii_results/full/pla/g/subject_level');
strparams='';
for i = 1:length(table_nonan.Sub_ID)
    strparams=strcat(strparams,{' "'}, DATAPATH, filesep, table_nonan.Sub_ID(i), '.nii"');
end
command=strcat('fslmerge -t all_data ', strparams, {' '});

% beware, this might be platform-dependent, adjust if neccessary
system(['source ~/.bashrc; export FSLOUT1PUTTYPE=NIFTI;' command{:}]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Run PALM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

csvwrite('variancegroups.csv',grp2idx(nominal(table_nonan.Study_ID)))
csvwrite('design_simple_studymod.csv',design_matrix)
csvwrite('contrast_simple_studymod.csv',contrast)
writetable(table_nonan, 'table_nonan.csv')

%contrast=   [1,2;
%            3,4]

disp('* Run PALM...')
% adjust mask path if needed
%palm -i all_data.nii -m /home/analyser/Dropbox/Boulder_Essen/Analysis/G_meta_analysis_whole_brain/GIV/nii_results/full_masked_10_percent.nii -d design

