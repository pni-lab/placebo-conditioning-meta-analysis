%rank transformation per volume, within mask
mask=niftiread('full_masked_10_percent.nii');

files = dir('split/*.nii');
for k = 1:length(files)
    vol=niftiread(strcat('split/', files(k).name));
    %[~, ~, vol(mask>0)] = unique(vol(mask>0));
    vol(mask>0) = tiedrank(vol(mask>0));

    niftiwrite(vol, strcat('split_tranked/', files(k).name), niftiinfo(strcat('split/', files(k).name)));
end


