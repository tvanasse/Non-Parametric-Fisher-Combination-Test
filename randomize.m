%%%%%%%%%%%% randomize.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CC - Civilian Controls
% CEC - Combat-exposed Controls
% PTSD - Posttraumatic Stress Disorder

%indices of real groups
CC_real_indices = (1:25);
PTSD_real_indices = (26:75);
CEC_real_indices = (76:103);

%Load z-score images as one merged nifti file (i.e., one time-point is one subject)
Volume = load_nii('/../Volumes/IC_#_merge.nii');

%Load binarized SDR mask image
mask = load_nii('/../Significant_Discriminatory_Regions/SDR_#.nii');

%Get indices of non-zero values for mask
ind = find(mask.img);
[i1, i2, i3] = ind2sub(size(mask.img), ind);
fprintf('Mask size: %d\n', length(i1))

%Get masked values for each group 
[CC_real, PTSD_real, CEC_real] = mask_function(i1, i2, i3, Volume, CC_real_indices, PTSD_real_indices, CEC_real_indices);

%Perform pairwise t-test for groups
%Permute image matrices so (two-sample two-sided t-test)
[h,p] = ttest2(permute(CC_real,[2 1]),permute(PTSD_real,[2 1]));
CCvsPTSD_real_p = squeeze(p);

[h,p] = ttest2(permute(CEC_real,[2 1]),permute(PTSD_real,[2 1]));
CECvsPTSD_real_p = squeeze(p);

[h,p] = ttest2(permute(CC_real,[2 1]),permute(CEC_real,[2 1]));
CCvsCEC_real_p = squeeze(p);

%Calculate Fisher combined probability test statistic for pairwise tests
chi_vals = -2.*log(CCvsPTSD_real_p);
CCvsPTSD_chi_sq = sum(chi_vals);

chi_vals = -2.*log(CECvsPTSD_real_p);
CECvsPTSD_chi_sq = sum(chi_vals);

chi_vals = -2.*log(CCvsCEC_real_p);
CCvsCEC_chi_sq = sum(chi_vals);


%%%%%%%%%%%% PERMUTATION TESTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set count variable equal to zero
count_CCvsPTSD = 0;
count_CECvsPTSD = 0;
count_CCvsCEC = 0;

%set number of iterations, NITER
NITER = 10000;
fprintf('Number of iterations: %d\n',NITER);

for iter = 1:NITER
    %randomly permute group indices
    permutation = randperm(103);

    CC_perm_indices = permutation(1:25);
    PTSD_perm_indices = permutation(26:75);
    CEC_perm_indices = permutation(76:103);

    %Get masked values for each permuted group
    [CC_perm, PTSD_perm, CEC_perm] = mask_function(i1, i2, i3, Volume, CC_perm_indices, PTSD_perm_indices, CEC_perm_indices);

    %Perform pairwise t-test for groups
    %Permute image matrices so (two-sample two-sided t-test)
    [h,p] = ttest2(permute(CC_perm,[2 1]),permute(PTSD_perm,[2 1]));
    CCvsPTSD_perm_p = squeeze(p);

    [h,p] = ttest2(permute(CEC_perm,[2 1]),permute(PTSD_perm,[2 1]));
    CECvsPTSD_perm_p = squeeze(p);

    [h,p] = ttest2(permute(CC_perm,[2 1]),permute(CEC_perm,[2 1]));
    CCvsCEC_perm_p = squeeze(p);

    %Calculate Fisher combined probability for pairwise tests
    chi_vals = -2.*log(CCvsPTSD_perm_p);
    CCvsPTSD_chi_sq_perm = sum(chi_vals);
    %if combined p-value is greater than real, count!
    if CCvsPTSD_chi_sq_perm > CCvsPTSD_chi_sq
        count_CCvsPTSD = count_CCvsPTSD +1;
    end 

    chi_vals = -2.*log(CECvsPTSD_perm_p);
    CECvsPTSD_chi_sq_perm = sum(chi_vals);
    %if combined p-value is less than real, count!
    if CECvsPTSD_chi_sq_perm > CECvsPTSD_chi_sq
        count_CECvsPTSD = count_CECvsPTSD +1;
    end 

    chi_vals = -2.*log(CCvsCEC_perm_p);
    CCvsCEC_chi_sq_perm = sum(chi_vals);
    %if combined p-value is less than real, count!
    if CCvsCEC_chi_sq_perm > CCvsCEC_chi_sq
        count_CCvsCEC = count_CCvsCEC +1;
    end 
    
end 

CCvsPTSD_non_parametric_combined_p = count_CCvsPTSD/NITER
CECvsPTSD_non_parametric_combined_p = count_CECvsPTSD/NITER
CCvsCEC_non_parametric_combined_p = count_CCvsCEC/NITER
