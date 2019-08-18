#APPEND TO MERGE_DATA.R


#First get reg table from main merged output:
reg_biotype <- regulatory_subset %>%  group_by(BIOTYPE) %>% summarise(counts = n_distinct(X.Uploaded_variation))
regulatory_subset <- subset(regulatory, select = c(X.Uploaded_variation, Location, Feature, Consequence, BIOTYPE, Promoter_histone_marks, Enhancer_histone_marks))


#reg_biotype <- regulatory_subset %>%  group_by(BIOTYPE) %>% summarise(counts = n_distinct(X.Uploaded_variation))
regulatory_subset %>%
  group_by(BIOTYPE) %>%
  summarise(counts = n_distinct(X.Uploaded_variation)) %>% #instead of n to count all, since repeated ids
  ggplot(aes(x = BIOTYPE, y = counts, fill = BIOTYPE)) +
    geom_bar(stat = "identity") +
    theme_classic() +
    labs(
      x = "Biotype of regulatory feature",
      y = "Number of distinct rsIDs",
      title = "Test plotting of regulatory features"
      )

#reg_Phistone
regulatory_subset %>%
  group_by(Promoter_histone_marks) %>%
  summarise(counts = n_distinct(X.Uploaded_variation))

#reg_Ehistone