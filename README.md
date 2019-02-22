# Non-parametric Fisher Combined Probability Test

For each significant discriminatory region (SDR) identified, the non-parametric combination method (randomize.m) consists of two phases: 
- testing separate hypotheses (3 pair-wise contrasts among subject groups) and combining the empirical p-values (across voxels in an SDR) for each hypothesis into a joint statistic in each permutation 
- summarizing results from multiple permutations of subject group designations into a joint statistic and obtaining the p-value of the joint test.

In each of the 10000 (NITER) permutations, we performed the following three steps. (1) We generated three dummy groups by randomly rearranging all subjects of the original three groups (i.e., CC-Civilian Control, PTSD-Posttraumatic Stress Disorder, and CEC-Combat-exposed Control groups). Each of the dummy groups had the same number of subjects with the original group. (2) Consistent with the processing on the original/real groups, for each comparison, we applied a two-tailed two-sample t-test on the Z-score of each voxel within an SDR between two groups (CC vs. PTSD, CC vs. CEC, CEC vs. PTSD), resulting in a p-value for each voxel in the permutation run. (3) For each comparison between two groups, Fisher’s combination method was used to combine the voxel-wise extreme value probabilities (i.e., p-values) from the permutation run. We summarized the results from 10000 permutation runs by calculating the occurring frequency of the case where the test statistic (chi-squared) using rearranged groups (i.e., the dummy groups) was greater than the test statistic chi-squared using the original (i.e., real) groups (i.e., the case where the combined p-value in permutation run was smaller than the combined p-value using the real groups). The frequency (i.e., the tail probability computed from 10000 permutations) reflects the final combined p-value for one-pair associated comparison (e.g., CC vs. PTSD).

Text is paraphrased from:
Du Y, Fryer SL, Lin D, Sui J, Yu Q, Chen J, Stuart B, Loewy RL, Calhoun VD, Mathalon DH (2018): Identifying functional network changing patterns in individuals at clinical high-risk for psychosis and patients with early illness schizophrenia: A group ICA study. Neuroimage Clin 17:335–346.

More information regarding non-parametric statsitical tests can be found from: Winkler AM, Webster MA, Brooks JC, Tracey I, Smith SM, Nichols TE (2016): Non-parametric combination and related permutation tests for neuroimaging. Hum Brain Mapp 37:1486–1511.

[From Wikipedia](https://en.wikipedia.org/wiki/Fisher%27s_method):

![alt text](https://wikimedia.org/api/rest_v1/media/math/render/svg/3a3edd04279a402a9088170ce771354f4398d3fb)

![alt text](https://upload.wikimedia.org/wikipedia/en/e/e5/Kequals2.jpg)
