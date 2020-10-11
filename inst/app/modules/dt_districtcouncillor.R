output$dt_districtcouncillor = renderDT(
  expr = {
    select(.data = data_master_raw,
           Region,
           District,
           Constituency = DropDownText,
           DC)
  }, #expr
  filter = "top",
  rownames = FALSE,
  options = list(lengthMenu = list(c(10, 20, -1),
                                   c('10', '20', 'All')),
                 pageLength = 20,
                 buttons = list(
                   list(
                     extend = "collection",
                     text = 'Show All',
                     action = DT::JS("function ( e, dt, node, config ) {
                                    dt.page.len(-1);
                                    dt.ajax.reload();
                                }")
                   ) #list
                 ) #list
  ) #list
  
) #renderDT