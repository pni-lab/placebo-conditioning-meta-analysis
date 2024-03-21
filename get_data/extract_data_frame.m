function table=extract_data_frame(df)
% Extract data frame for PALM-based analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the following is edited manually:
%stim location {'L forearm (v)';'L & R hand (d)';'R calf (d)';'L hand (d)';'L forearm (v)';'L forearm (d)';'C rectal';'R forearm (v)';'L forearm (v)';'L forearm (v)';'R forearm (v)';'R forearm (v)';'L or R foot (d)';'L hand (d)';'L & R forearm (v)';'C rectal';'R forearm (v)';'L forearm (v)';'L forearm (v)';'R leg (d)'}
%DF_STIM_SIDE={'L';'LR';'R';'L';'L';'L';'C';'R';'L';'L';'R';'R';'LR';'L';'LR';'C';'R';'L';'L';'R'}
DF_STIM_LOC={'forearm';'hand';'leg';'hand';'forearm';'forearm';'rectal';'forearm';'forearm';'forearm';'forearm';'forearm';'leg';'hand';'forearm';'rectal';'forearm';'forearm';'forearm';'leg'};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


STUDY_ID={};
SUB_ID={};
MALE={};
AGE={};
TR={};
TE={};
FWHM={};
STIM_TYPE={};
STIM_DUR={};
CON_FILE={};
RATING_PAIN_CTR={};
RATING_DIFF={};
NPS_PAIN={};
NPS_PLC={};
MHE_PAIN={};
MHE_PLC={};
SIIPS_PAIN={};
SIIPS_PLC={};
CONDITIONING={};
STIM_SIDE={};
STIM_LOC={};
for i = 1:length(df.study_ID)
    if (strcmp(df.study_design(i), 'within'))
        SUB_ID=[SUB_ID; df.subjects{i,1}.sub_ID];
        STUDY_ID=[STUDY_ID; df.subjects{i,1}.study_ID];
        MALE=[MALE; num2cell(df.subjects{i,1}.male)];
        AGE=[AGE; num2cell(df.subjects{i,1}.age)];
        for j = 1:length(df.subjects{i,1}.sub_ID)
            CON_FILE=[CON_FILE; df.subjects{i,1}.placebo_minus_control{j,1}.img];
            RATING_PAIN_CTR=[RATING_PAIN_CTR; df.subjects{i,1}.pain_control{j,1}.rating101];
            RATING_DIFF=[RATING_DIFF; df.subjects{i,1}.placebo_minus_control{j,1}.rating101];
            STIM_SIDE=[STIM_SIDE; df.subjects{i,1}.placebo_minus_control{j,1}.stim_side];
            NPS_PAIN=[NPS_PAIN; num2cell(df.subjects{i,1}.pain_control{j,1}.NPS)];
            NPS_PLC=[NPS_PLC; num2cell(df.subjects{i,1}.placebo_minus_control{j,1}.NPS)];
            MHE_PAIN=[MHE_PAIN; num2cell(df.subjects{i,1}.pain_control{j,1}.MHE)];
            MHE_PLC=[MHE_PLC; num2cell(df.subjects{i,1}.placebo_minus_control{j,1}.MHE)];
            SIIPS_PAIN=[SIIPS_PAIN; num2cell(df.subjects{i,1}.pain_control{j,1}.SIIPS)];
            SIIPS_PLC=[SIIPS_PLC; num2cell(df.subjects{i,1}.placebo_minus_control{j,1}.SIIPS)];
            CONDITIONING=[CONDITIONING; df.placebo_induction(i)];
            TR=[TR;num2cell(df.TR(i))];
            TE=[TE;num2cell(df.TE(i))];
            FWHM=[FWHM;num2cell(df.spatial_smoothing_FWHM(i))];
            STIM_TYPE=[STIM_TYPE;num2cell(df.stim_type(i))];
            STIM_DUR=[STIM_DUR;num2cell(df.stimulus_duration(i))];
            %STIM_SIDE=[STIM_SIDE;DF_STIM_SIDE{i}];
            STIM_LOC=[STIM_LOC;DF_STIM_LOC{i}];
        end
    end
end
table=cell2table(horzcat(STUDY_ID, SUB_ID, MALE, AGE, NPS_PAIN, NPS_PLC, MHE_PAIN, MHE_PLC, SIIPS_PAIN, SIIPS_PLC, RATING_PAIN_CTR, RATING_DIFF, CONDITIONING, TR, TE, FWHM, STIM_TYPE, STIM_DUR, STIM_SIDE, STIM_LOC, CON_FILE),...
    'VariableNames',{'Study_ID' 'Sub_ID' 'Male' 'Age', 'NPS_pain_ctr', 'NPS_pain_plc', 'MHE_pain_ctr', 'MHE_plc', 'SIIPS_pain_ctr', 'SIIPS_plc', 'Rating_pain_ctr', 'Rating_diff', 'Conditioning',  'TR', 'TE', 'FWHM', 'Stim_Type', 'Stim_Dur', 'Stim_Side', 'Stim_Loc', 'Con_file'});



