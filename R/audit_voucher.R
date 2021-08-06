#' 凭证重分类前按月查询凭证汇总情况
#'
#' @param conn 连接
#' @param FYear 年月
#' @param FPeriod 月份
#'
#' @return 返回值
#' @export
#'
#' @examples
#' voucher_beforeReClass_costItem_summary()
voucher_beforeReClass_costItem_summary <- function(conn=tsda::conn_rds('jlrds'),
                                                   FYear = 2021,
                                                   FPeriod =6) {
  sql <- paste0("select  FCostItemNumber,FTotalRptAmt,FTotalCount  from mrpt_audit_voucher_summary
where FYear = ",FYear," and FPeriod =  ",FPeriod,"
order by FCostItemNumber")
  res <- tsda::sql_select(conn,sql)
  return(res)
}


#' 凭证重分类前按月查询凭证展开到科目+成本中心
#'
#' @param conn 连接
#' @param FYear 年月
#' @param FPeriod 月份
#' @param FCostItemNumber 总账科目代码/成本要素代码
#'
#' @return 返回值
#' @export
#'
#' @examples
#' voucher_beforeReClass_costItem_detail_costCenterNo()
voucher_beforeReClass_costItem_detail_costCenterNo <- function(conn=tsda::conn_rds('jlrds'),
                                                   FYear = 2021,
                                                   FPeriod =6,
                                                   FCostItemNumber='6001090100') {
  sql <- paste0("select FCostItemNumber,FCostCenterNo,FTotalRptAmt,FTotalCount from mrpt_audit_voucher_detail_ByCostCenterNo
where FYear = ",FYear," and FPeriod =  ",FPeriod," and FCostItemNumber = '",FCostItemNumber,"'")
  res <- tsda::sql_select(conn,sql)
  return(res)
}


#' 凭证重分类前按月查询凭证展开到科目+成本中心
#'
#' @param conn 连接
#' @param FYear 年月
#' @param FPeriod 月份
#' @param FCostItemNumber 总账科目代码/成本要素代码
#' @param FCostCenterNo 成本中心
#'
#' @return 返回值
#' @export
#'
#' @examples
#' voucher_beforeReClass_costItem_detail_list()
voucher_beforeReClass_costItem_detail_list <- function(conn=tsda::conn_rds('jlrds'),
                                                               FYear = 2021,
                                                               FPeriod =6,
                                                               FCostItemNumber='6001090100',
                                                               FCostCenterNo='10000830'
                                                               ) {
  sql <- paste0("select * from t_mrpt_data_sap_withReClassified
where  year(FPostDate)*100+MONTH(FPostDate) =  ",FYear*100+FPeriod," and
FCostItemNumber='",FCostItemNumber,"' and FCostCenterNo='",FCostCenterNo,"'")
  res <- tsda::sql_select(conn,sql)
  return(res)
}




