## analysing the CRW data to see
# whether CRW model is appropriate, by using net squared displacement

library(tidyverse)
library(magrittr)
## 1. read in the data

dat <- read.csv((file = here::here('tests', 'data', 'CRW_output_vonMis.csv')))

hist(dat$movelength)
hist(log(dat$movelength))
mean(log(dat$movelength))

dat_parms <- dat %>%
  arrange(id) %>%
  group_by(id) %>%
  mutate(Nmove = 1:n(),
         movel_2 = movelength^2,
         rad = (turnangle *pi)/180,
         cosRad = cos(rad),
         sinRad = sin(rad))


## 2. checking the autocorrelation
ci <- 0.95  ## expected CI level
dat_acf <- data.frame(id = numeric(), CI = numeric(), acf= numeric())
for (i in unique(dat_parms$id)){
  dat_sub <- subset(dat_parms, id == i)
  ACF <- acf(dat_sub$movelength)
  CI <- qnorm((1 + ci)/2)/sqrt(ACF$n.used)
  if  (any( abs(as.numeric(ACF$acf)[-1]) > CI))
  {warning('one sign lag for this individual ACF')}
  dat_acf <- rbind(dat_acf, data.frame(id = i, CI = CI, acf = as.numeric(ACF$acf)))
}

dat_acf <- dat_acf %>%
  group_by(id) %>%
  mutate(Nlag = 1:n(),
         Sign = case_when(
           abs(acf) > CI & Nlag == 1 ~ '1 lag',
           abs(acf) > CI & Nlag != 1 ~ 'Sign',
           abs(acf) < CI ~ 'Nonsign'
         ))
table(dat_acf$Sign)
dat_acf[dat_acf$Sign == 'Sign',]  ## inspecting

## 3. continue with preparing the data to have comparison of hte observed and expected squared net duisplacement
## add the first x and y to calc the observed net squared displacement at each step
dat_fstRow <- dat %>%
  arrange(id) %>%
  group_by(id) %>%
  filter(row_number()==1) %>%
  mutate(Orig_x = x,
         Orig_y = y) %>%
  select(id, Orig_x, Orig_y)

dat_merge <- merge(dat_parms,
                        dat_fstRow,
                        by = 'id')

dat_merge %<>%
  mutate(Obs_R2 = sqrt((x - Orig_x)^2 + (y - Orig_y)^2))

obs_R2_aver <- dat_merge %>%
  group_by(Nmove) %>%
  summarise(Aver_obsR2 = mean(Obs_R2, na.rm = T),
            SD_obsR2 = sd(Obs_R2, na.rm = T))

## here is a question: do I summarize per path or ACROSS paths?
sum_parms <- dat_parms %>%
  group_by(id) %>%
  # filter(Nmove <= 30) %>%   ## seeing whether using less steps avoids the mismatch
  summarize(Mean_mlength = mean(movelength),  ## m1 in Turchin's book p 139
            mean_ml2 = mean(movel_2),          ## m2 in Turchn's book p 139
            mean_cos = mean(cosRad),           ## psi in Turchin's book p 139
            mean_sin = mean(sinRad))           ## s in Turchin's book p 139
## so yes, sin is close to 0 therefore we can use formula 5.2

sum_parms_acrossPaths <- dat_parms %>%
  ungroup(id) %>%
  # filter(Nmove <= 30) %>%   ## seeing whether using less steps avoids the mismatch
  summarize(Mean_mlength = mean(movelength),  ## m1 in Turchin's book p 139
            mean_ml2 = mean(movel_2),          ## m2 in Turchn's book p 139
            mean_cos = mean(cosRad),           ## psi in Turchin's book p 139
            mean_sin = mean(sinRad))            ## s in Turchin's book p 139

dat_Net2exp <- data.frame(Nmove = c(1:50))
dat_Net2exp <- dat_Net2exp %>%
  mutate(N2 = Nmove*sum_parms_acrossPaths$mean_ml2 +
                       2*sum_parms_acrossPaths$Mean_mlength^2*(sum_parms_acrossPaths$mean_cos /
                                                                 1 - sum_parms_acrossPaths$mean_cos)*
           (Nmove - (1 - sum_parms_acrossPaths$mean_cos^(Nmove - 1)/2)/(1 - sum_parms_acrossPaths$mean_cos)))

# 4. plot of the observed vs expected squared net displacement
png('./tests/plots/vonMisesImplement_Comparison_obs_exp_NetSqDispl.png')
ggplot(data = obs_R2_aver, aes(x = Nmove, y = Aver_obsR2, col = 'observed')) +
  geom_point(pch = 1) +
  geom_errorbar(data  = obs_R2_aver,
                aes(ymin=Aver_obsR2-SD_obsR2, ymax = Aver_obsR2 + SD_obsR2,
                    col = 'observed'),
                width=.1) +  ## SD on each side of the observed values
  geom_point(data = dat_Net2exp, aes(x = Nmove, y= N2,
                                     col = 'expected')) +
  theme_bw() + xlab('Number steps') +
  ylab('Net squared displacement') +
  scale_color_manual(name = "Group",
                     values = c("observed" = "red", "expected" = "black"),
                     labels = c("expected", "observed")) +
  guides(col=guide_legend(title="Type"))
dev.off()


ggplot(dat_merge, aes(x= Nmove, y = Obs_R2, col = as.factor(id))) +
  geom_point()

ggplot(dat_Net2exp, aes(x = Nmove, y= N2)) +
  geom_point() +
  geom_point(data = subset(dat_merge, id == 8), aes(x = Nmove, y = Obs_R2),
             col= 'red')


#
# check_logn <- rlnorm(500, meanlog = 2.27, sdlog = 0.574002)
# hist(check_logn)
# hist(dat_vonM_merge$movelength, add = T, col = "#E690CB7D")
