library(ggplot2)
library(plotly)
library(bslib)

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(bootswatch = "flatly", success = "#FFBCEC"),
            includeCSS("styles.css")),
  img(src = "https://www.publichealthpost.org/wp-content/uploads/2021/10/102921_Immigration-covid.jpg"),
    h5(strong("Abi Chinn"),
    h5("FRENCH 229 - Winter 2022"),
    h6(strong("Project Background:")),
    p("My research project allowed me the opportunity to explore my growing passion for data science as an intended Informatics major by creating a Shiny application with R Studio that will allow people to see where immigrants from different regions in the world are residing in the United States. Utilizing my coding experience in INFO 201, I was able to create a visualization to answer my research questions on whether immigrants have specific states they overall immigrate to and whether where immigrants are from has an impact on where they immigrate to. My visualization lacks the states Alaska and Hawaii because plotting states in R Studio takes the longitude and latitude coordinates, and those states are a distance away from the mainland. Through my project, I got the chance to explore where immigrants from various regions have resided in the U.S. in 2018 with Pew Research Center's Facts on U.S. immigrants for the year 2018, specifically with the data on the", a("regions and top states of residence of U.S. immigrants", href = "https://www.pewresearch.org/hispanic/wp-content/uploads/sites/5/2020/08/Pew-Research-Center_Regions-States-Current-Data_Statistical-Portrait-of-the-Foreign-Born-2018.xlsx"), ". The source of the data is the Pew Research Center tabulations of 2018, American Community Survey, 1% Integrated Public Use Microdata Series, which provides census data internationally."),
    p(em("Illustration via Getty Images"))
    
  )
)

plot_sidebar <- sidebarPanel(
    selectInput(
      inputId = "user_category",
      label = "Select a Region to View for the States of Residence of U.S. Immigrants:",
      choices = list("Foreign Born" = "Foreign_born", 
                     "Mexico" = "Mexico", 
                     "East and Southeast Asia" = "East_and_Southeast_Asia", 
                     "Central Asia" = "Central_Asia", 
                     "South Asia" = "South_Asia", 
                     "Oceania" = "Oceania", 
                     "Europe" = "Europe", 
                     "Canada and Other North America" = "Canada_and_Other_North_America", 
                     "Caribbean" = "Caribbean", 
                     "Central America" = "Central_America", 
                     "South America" = "South_America", 
                     "Middle East-North Africa" = "Middle_East_North_Africa", 
                     "Sub-Saharan Africa" = "Sub_Saharan_Africa"
                     ),
    ))

plot_main <- mainPanel(
  plotlyOutput(outputId = "statePlot") 
)


plot_tab <- tabPanel(
  "Immigrant Numbers by State",
  fluidPage(
   ),
  sidebarLayout(
    plot_sidebar,
    plot_main),
      
    )




ui <- navbarPage(
  "Immigrants in America",
  intro_tab,
  plot_tab
)