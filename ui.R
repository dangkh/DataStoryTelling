library(shinydashboard)
library(shiny)
library(DT)
library(highcharter)
library(quantmod)
library(scales)
library(ggplot2)
source('helper_funcs.R')
library(tidyverse)
library(dplyr)
stockNames = c('STB', 'NVL', 'VJC', 'VRE', 'VHM', 'KDH', 'VNM', 'TCH', 'PNJ', 'FPT', 'BID', 'POW', 'MBB', 'PLX', 'GAS', 'HPG', 'HDB', 'MWG', 'VCB', 'SSI', 'TCB', 'CTG', 'BVH', 'PDR', 'VIC', 'REE', 'TPB', 'MSN', 'SBT')
dashboardPage(
  dashboardHeader(
    title=div(img(src="https://vinuni.ap.panopto.com/Panopto/ContentCache/637196699518830531/_branding/6f870251-830c-4808-9e77-ab7d004564ea/637196697191200399_embedlogo.png", height = '50', width ='50'), "Data Visualization"),
    dropdownMenuOutput("messageMenu")
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("DetailBoard", tabName = "detail", icon = icon("th"), badgeLabel = "developing", badgeColor = "green")
    )
  ),
  skin = "black",
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              h2(paste0("Market Watch")),
              fluidRow(
                valueBoxOutput("m1") ,
                valueBoxOutput("m2") ,
                valueBoxOutput("m3")
              ),
              h2(paste0("Spotlight")),
              fluidRow(
                valueBoxOutput("up1", width = 2),
                valueBoxOutput("up2", width = 2),
                valueBoxOutput("up3", width = 2),
                valueBoxOutput("ExGBox", width = 2) ,
                valueBoxOutput("ImGBox", width = 2) ,
                valueBoxOutput("BlGBox", width = 2)
              ),
              fluidRow(
                column(highchartOutput("plotd"), width = 4),
                column(highchartOutput("plot1"), width = 4),
                column(
                  tabsetPanel(
                    id = 'dataset',
                    tabPanel("increase", DT::dataTableOutput("mytable1")),
                    tabPanel("decrease", DT::dataTableOutput("mytable2")),
                    tabPanel("volume", DT::dataTableOutput("mytable3"))
                  )
                  , width = 4)
              ),
              fluidRow(
                column( width = 12,h4("Stock Pice", align = 'center'), highchartOutput('lineHC') )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "detail",
              h2("DetailBoard tab content"),
              sidebarLayout(
                sidebarPanel(
                  selectInput("stockdetail", "Select Stock:", choices = stockNames, selected = stockNames[1])
                ),
                
                mainPanel(highchartOutput("stock_chart_detail"))
              )
      )
    )
  )
)