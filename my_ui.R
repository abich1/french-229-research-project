library(ggplot2)
library(plotly)
library(bslib)

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(bootswatch = "flatly", success = "#FFBCEC"),
            includeCSS("styles.css")),
  img(src = "https://www.publichealthpost.org/wp-content/uploads/2021/10/102921_Immigration-covid.jpg"),
    h5(strong("Abi Chinn"),
    h6("FRENCH 229 - Winter 2022"),
    p("Author's Statement: "),
    em("Illustration via Getty Images")
    
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

bib <- tabPanel(
  "Bibliography",
  fluidPage(
    h6(strong("Bibliography")
    )
  ))


ui <- navbarPage(
  "Immigrants in America",
  intro_tab,
  plot_tab,
  bib
)