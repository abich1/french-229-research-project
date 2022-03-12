library(ggplot2)
library(plotly)
library(dplyr)
library(readxl)
# install.packages("usmap")
library(usmap)


custom_titles <- reactiveValues("Foreign_born" = "The Number of Foreign Born People in ", 
                                "Mexico" = "Mexico", 
                                "East_and_Southeast_Asia" = "East and Southeast Asia", 
                                "Central_Asia" = "Central Asia", 
                                "South_Asia" = "South Asia", 
                                "Oceania" = "Oceania", 
                                "Europe" = "Europe", 
                                "Canada_and_Other_North_America" = "Canada and Other North America", 
                                "Caribbean" = "Caribbean", 
                                "Central_America" = "Central America", 
                                "South_America" = "South America", 
                                "Middle_East_North_Africa" = "Middle East-North Africa", 
                                "Sub_Saharan_Africa" = "Sub-Saharan Africa"
)

data <- read_excel("Book1.xlsx")

state_shape <- map_data('state')

# Load built-in state names and abbreviations
state_abbrevs <- data.frame(state.abb, state.name)

#Join `incarceration_data` and  `state_abbrevs`
data <- left_join(data, state_abbrevs, by=c('State' = 'state.name'))

# Add a new column to the `incarceration_data` dataframe called "region" that includes a lowercase version of the state name
data <- data %>% 
  mutate("region" = tolower(State))

#Join `state_shape` and `incarceration_data`
state_shape <- left_join(state_shape, data, by='region')
state_shape$Oceania <- as.numeric(state_shape$Oceania)
state_shape$Foreign_born <- as.numeric(state_shape$Foreign_born)
state_shape$Mexico <- as.numeric(state_shape$Mexico)
state_shape$East_and_Southeast_Asia <- as.numeric(state_shape$East_and_Southeast_Asia)
state_shape$Central_Asia <- as.numeric(state_shape$Central_Asia)
state_shape$South_Asia <- as.numeric(state_shape$South_Asia)
state_shape$Europe <- as.numeric(state_shape$Europe)
state_shape$Canada_and_Other_North_America <- as.numeric(state_shape$Canada_and_Other_North_America)
state_shape$Caribbean <- as.numeric(state_shape$Caribbean)
state_shape$Central_America <- as.numeric(state_shape$Central_America)
state_shape$South_America <- as.numeric(state_shape$South_America)
state_shape$Middle_East_North_Africa <- as.numeric(state_shape$Middle_East_North_Africa)
state_shape$Sub_Saharan_Africa <- as.numeric(state_shape$Sub_Saharan_Africa)


server <- function(input, output) {
  
  output$statePlot <- renderPlotly({
    # Make a line chart of the number of user selected data over time
    # Allow the user to select the category
    my_plot <- ggplot(state_shape) +
      geom_polygon(mapping = aes(x = long, y = lat, group = group, fill = get(input$user_category), text = paste0('State: ', State, '\n', 'Number of People: ', get(input$user_category)))) +
      coord_map() +
      labs(title = custom_titles[[input$user_category]], fill = "Number of People") +
      theme(
        axis.line = element_blank(), # Remove grid background and lat and long
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank()) +
      scale_fill_continuous(low = 'light pink', high ='dark blue', labels = scales::label_number_si())
    
    
    # Make interactive plot
    # Remove mode bar
    my_plotly <- ggplotly(my_plot, tooltip=c('text')) %>%
      config(displayModeBar = FALSE)  
    
    return(my_plotly)
    
  })
  
}


cities_t <- usmap_transform(data)

plot_usmap(fill = Oceania, alpha = 0.25) +
  ggrepel::geom_label_repel(data = cities_t,
                            aes(x = x, y = y, label = most_populous_city),
                            size = 3, alpha = 0.8,
                            label.r = unit(0.5, "lines"), label.size = 0.5,
                            segment.color = "red", segment.size = 1,
                            seed = 1002) +
  geom_point(data = cities_t,
             aes(x = x, y = y, size = city_pop),
             color = "purple", alpha = 0.5) +
  scale_size_continuous(range = c(1, 16),
                        label = scales::comma) +
  labs(title = "Most Populous City in Each US State",
       subtitle = "Source: US Census 2010",
       size = "City Population") +
  theme(legend.position = "right")
