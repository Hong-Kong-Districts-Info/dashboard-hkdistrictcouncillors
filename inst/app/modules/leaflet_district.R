output$plot_district <- renderLeaflet(
  expr = {
    
    map_hk_districts %>% 
      addPolygons(data = react_district_highlight(),
                  color = '#D55E00',
                  weight = 0.5,
                  fillOpacity = 0.6) %>% 
      addPopups(lng = react_district_highlight()$centroids[,"X"],
                lat = react_district_highlight()$centroids[,"Y"], 
                popup = react_district_highlight()$DropDownText) %>% 
      # centre map on user-chosen district
      setView(lng = react_district_highlight()$centroids[,"X"],
              lat = react_district_highlight()$centroids[,"Y"], 
              zoom = 11)
    
  }
)