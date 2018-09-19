function row_selected(grid_name) {
  var selectedrowindex = $(grid_name).jqxGrid('getselectedrowindex');
  var datarow = $(grid_name).jqxGrid('getrowdata', selectedrowindex);
  return datarow;
}