library(ggplot2)
library(plotly)
library(dplyr)
library(readxl)


custom_titles <- reactiveValues("Foreign_born" = "The Number of Foreign Born Immigrants in the U.S. in 2018", 
                                "Mexico" = "The Number of Mexican Immigrants in the U.S. in 2018.", 
                                "East_and_Southeast_Asia" = "The Number of East and Southeast Asian Immigrants in the U.S. in 2018", 
                                "Central_Asia" = "The Number of Central Asian Immigrants in the U.S. in 2018", 
                                "South_Asia" = "The Number of South Asian Immigrants in the U.S. in 2018", 
                                "Oceania" = "The Number of Oceanian Immigrants in the U.S. in 2018", 
                                "Europe" = "The Number of European Immigrants in the U.S. in 2018", 
                                "Canada_and_Other_North_America" = "The Number of Canadian and Other North American Immigrants in the U.S. in 2018", 
                                "Caribbean" = "The Number of Caribbean Immigrants in the U.S. in 2018", 
                                "Central_America" = "The Number of Central American Immigrants in the U.S. in 2018", 
                                "South_America" = "The Number of South American Immigrants in the U.S. in 2018", 
                                "Middle_East_North_Africa" = "The Number of Middle East-North African Immigrants in the U.S. in 2018", 
                                "Sub_Saharan_Africa" = "The Number of Sub-Saharan African Immigrants in the U.S. in 2018"
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
      geom_polygon(mapping = aes(x = long, y = lat, group = group, fill = get(input$user_category), text = paste0('State: ', State, '\n', 'Number of Immigrants: ', get(input$user_category)))) +
      coord_map() +
      labs(title = custom_titles[[input$user_category]], fill = "Number of Immigrants") +
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
    
})}
