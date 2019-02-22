function [ group_1_masked, group_2_masked, group_3_masked] = mask_function(i1,i2,i3, Volume, Group1, Group2, Group3)
%mask_function returns array of image values within proivded mask
%indices: i1 = x's, i2 = y's, i3 = z's; Volume is the concatenated
%image; Groups are the three group indices 

    group_1_masked = zeros(length(i1), length(Group1));
    group_2_masked = zeros(length(i1), length(Group2));
    group_3_masked = zeros(length(i1), length(Group3));
    
    for mask = 1:length(i1)
        group_1_masked(mask,:) = Volume.img(i1(mask),i2(mask),i3(mask),Group1);
        group_2_masked(mask,:) = Volume.img(i1(mask),i2(mask),i3(mask),Group2);
        group_3_masked(mask,:) = Volume.img(i1(mask),i2(mask),i3(mask),Group3);
        mask = mask +1;
    end
    
end

