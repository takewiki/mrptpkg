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
  sql <- paste0("select  FCostItemNumber,FCostItemName,FTotalRptAmt,FTotalCount  from mrpt_audit_voucher_summary
where FYear = ",FYear," and FPeriod =  ",FPeriod,"
order by FCostItemNumber")
  res <- tsda::sql_select(conn,sql)
  return(res)
}

#' 凭证重分类后按月查询凭证汇总情况
#'
#' @param conn 连接
#' @param FYear 年月
#' @param FPeriod 月份
#'
#' @return 返回值
#' @export
#'
#' @examples
#' voucher_afterReClass_costItem_summary()
voucher_afterReClass_costItem_summary <- function(conn=tsda::conn_rds('jlrds'),
                                                   FYear = 2021,
                                                   FPeriod =6) {
  sql <- paste0("select  FCostItemNumber,FCostItemName,FTotalRptAmt,FTotalCount  from mrpt_audit_voucherAfter_summary
where FYear = ",FYear," and FPeriod =  ",FPeriod,"
order by FCostItemNumber")
  res <- tsda::sql_select(conn,sql)
  return(res)
}

#' 凭证重分类后按月查询凭证汇总情况-仅仅包括重分类凭证
#'
#' @param conn 连接
#' @param FYear 年月
#' @param FPeriod 月份
#'
#' @return 返回值
#' @export
#'
#' @examples
#' voucher_onlyReClass_costItem_summary()
voucher_onlyReClass_costItem_summary <- function(conn=tsda::conn_rds('jlrds'),
                                                  FYear = 2021,
                                                  FPeriod =6) {
  sql <- paste0("select  FReClassifiedNumber,FCostItemNumber,FCostItemName,FTotalRptAmt,FTotalCount
from mrpt_audit_voucher_onlyReclass_summary
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
  sql <- paste0("select FCostItemNumber,FCostCenterNo,FCostCenterName,FTotalRptAmt,FTotalCount
from mrpt_audit_voucher_detail_ByCostCenterNo
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
#'
#' @return 返回值
#' @export
#'
#' @examples
#' voucher_afterReClass_costItem_detail_costCenterNo()
voucher_afterReClass_costItem_detail_costCenterNo <- function(conn=tsda::conn_rds('jlrds'),
                                                               FYear = 2021,
                                                               FPeriod =6,
                                                               FCostItemNumber='6001090100') {
  sql <- paste0("select FCostItemNumber,FCostCenterNo,FCostCenterName,FTotalRptAmt,FTotalCount
from mrpt_audit_voucherAfer_detail_ByCostCenterNo
where FYear = ",FYear," and FPeriod =  ",FPeriod," and FCostItemNumber = '",FCostItemNumber,"'")
  res <- tsda::sql_select(conn,sql)
  return(res)
}


#' 凭证重分类后按月查询凭证展开到科目+成本中心-仅重分类凭证
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
#' voucher_onlyReClass_costItem_detail_costCenterNo()
voucher_onlyReClass_costItem_detail_costCenterNo <- function(conn=tsda::conn_rds('jlrds'),
                                                              FYear = 2021,
                                                              FPeriod =6,
                                                              FReClassifiedNumber ='D001') {
  sql <- paste0("select FReClassifiedNumber,
FCostItemNumber,FCostCenterNo,FCostCenterName,FTotalRptAmt,FTotalCount
from mrpt_audit_voucherOnly_detail_ByCostCenterNo
where FYear = ",FYear," and FPeriod =  ",FPeriod," and FReClassifiedNumber = '",FReClassifiedNumber,"'")
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


#' 凭证重分类后按月查询凭证展开到科目+成本中心
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
voucher_afterReClass_costItem_detail_list <- function(conn=tsda::conn_rds('jlrds'),
                                                       FYear = 2021,
                                                       FPeriod =6,
                                                       FCostItemNumber='6001090100',
                                                       FCostCenterNo='10000830'
) {
  sql <- paste0("select * from rds_t_mrpt_data_sap_withReClassified
where  year(FPostDate)*100+MONTH(FPostDate) =  ",FYear*100+FPeriod," and
FCostItemNumber_all ='",FCostItemNumber,"' and FCostCenterNo='",FCostCenterNo,"'")
  res <- tsda::sql_select(conn,sql)
  return(res)
}

#' 凭证重分类后按月查询凭证展开到科目+成本中心
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
#' voucher_onlyReClass_costItem_detail_list()
voucher_onlyReClass_costItem_detail_list <- function(conn=tsda::conn_rds('jlrds'),
                                                      FYear = 2021,
                                                      FPeriod =6,
                                                     FReClassifiedNumber ='D001',
                                                     FCostCenterNo ='10000775'
) {
  sql <- paste0("select  *
from rds_t_mrpt_data_sap_withReClassifiedOnly
 where  year(FPostDate)*100+MONTH(FPostDate) =  ",FYear*100+FPeriod," and

                FReClassifiedNumber ='",FReClassifiedNumber,"' and FCostCenterNo ='",FCostCenterNo,"'")
  res <- tsda::sql_select(conn,sql)
  return(res)
}





