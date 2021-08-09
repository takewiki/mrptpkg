#' 检验成本要素的正确性
#'
#' @param conn  连接
#' @param FYear 年份
#' @param FPeriod 月份
#'
#' @return 返回值
#' @export
#'
#' @examples
#' md_costItem_audit_summary()
md_costItem_audit_summary <- function(conn=tsda::conn_rds('jlrds'),
                                                   FYear = 2021,
                                                   FPeriod =6){
  sql <- paste0("select  FFeeName,FTotalCount  from rds_vw_mrpt_md_costItem_summary
where FYear = ",FYear," and FPeriod =  ",FPeriod,"
order by FFeeName")
  res <- tsda::sql_select(conn,sql)
  return(res)

}

#' 查看成本要素明细内容
#'
#' @param conn 连接
#' @param FYear 年份
#' @param FPeriod 月份
#' @param FFeeName 统一费用名称名称
#'
#' @return 返回值
#' @export
#'
#' @examples
#' md_costItem_audit_detail()
md_costItem_audit_detail <- function(conn=tsda::conn_rds('jlrds'),
                                      FYear = 2021,
                                      FPeriod =6,
                                      FFeeName =''
                                     ){
  sql <- paste0("select FFeeName,FCostItemNumber,FCostItemName,FRptItemName from
rds_vw_mrpt_costItem_sap
where FYear = ",FYear," and FPeriod =  ",FPeriod," and FFeeName ='",FFeeName,"'
order by FFeeName")
  res <- tsda::sql_select(conn,sql)
  return(res)

}


#' 成本中心审计
#'
#' @param conn 连接
#' @param FYear 年份
#' @param FPeriod 期间
#'
#' @return 返回值
#' @export
#'
#' @examples
#' md_costCenter_audit_summary()
md_costCenter_audit_summary <- function(conn=tsda::conn_rds('jlrds'),
                                      FYear = 2021,
                                      FPeriod =6){
  sql <- paste0("select  FFinancialPartner,FType,FTotalValue,FTotalCount
from rds_vw_md_costCenter_summary
where FYear = ",FYear," and FPeriod =  ",FPeriod,"
order by FFinancialPartner")
  res <- tsda::sql_select(conn,sql)
  return(res)

}

#' 成本中心审计的明细项
#'
#' @param conn 连接
#' @param FYear 年份
#' @param FPeriod 期间
#' @param FFinancialPartner 财务伙伴
#' @param FType 渠道类型
#'
#' @return 返回值
#' @export
#'
#' @examples
#' md_costCenter_audit_detail()
md_costCenter_audit_detail <- function(conn=tsda::conn_rds('jlrds'),
                                        FYear = 2021,
                                        FPeriod =6,
                                       FFinancialPartner='周彬,李娟',
                                       FType = '渠道'){
  sql <- paste0("select  FFinancialPartner,FType,FBrand,FChannel,FTotalValue,FTotalCount
from rds_vw_md_costCenter_detail
where FYear = ",FYear," and FPeriod =  ",FPeriod," and FFinancialPartner='",FFinancialPartner,"'
and FType = '",FType,"'
order by FFinancialPartner")
  res <- tsda::sql_select(conn,sql)
  return(res)

}


#' 成本中心审计的明细项-独立成本中心
#'
#' @param conn 连接
#' @param FYear 年份
#' @param FBrand2  品牌
#' @param FChannel2 渠道
#' @param FPeriod 期间
#'
#' @return 返回值
#' @export
#'
#' @examples
#' md_costCenter_audit_detail()
md_costCenter_audit_detail_owned <- function(conn=tsda::conn_rds('jlrds'),
                                       FYear = 2021,
                                       FPeriod =6,
                                       FBrand2 = '自然堂',
                                       FChannel2 ='商超'){
  sql <- paste0("select FCostCenter,FType,FValue,FBrand2,FChannel2, FNote from rds_vw_md_costCenter_owned
where  FYear =",FYear," and FPeriod = ",FPeriod,"  and
FBrand2 = '",FBrand2,"' and FChannel2 ='",FChannel2,"'  order by FType,FCostCenter")
  res <- tsda::sql_select(conn,sql)
  return(res)

}


#' 成本中心审计的明细项-共享成本中心
#'
#' @param conn 连接
#' @param FYear 年份
#' @param FBrand2  品牌
#' @param FChannel2 渠道
#' @param FPeriod 期间
#'
#' @return 返回值
#' @export
#'
#' @examples
#' md_costCenter_audit_detail_shared()
md_costCenter_audit_detail_shared <- function(conn=tsda::conn_rds('jlrds'),
                                             FYear = 2021,
                                             FPeriod =6,
                                             FBrand2 = '自然堂',
                                             FChannel2 ='商超'){
  sql <- paste0("select FCostCenter,FType,FValue,FBrand2,FChannel2, FNote from rds_vw_md_costCenter_shared
where  FYear =",FYear," and FPeriod = ",FPeriod,"  and
FBrand2 = '",FBrand2,"' and FChannel2 ='",FChannel2,"'  order by FType,FCostCenter")
  res <- tsda::sql_select(conn,sql)
  return(res)

}


#' 查看共享成本中心的详细信息
#'
#' @param conn 连接
#' @param FYear 年
#' @param FPeriod 月
#' @param FCostCenter 成本中心
#'
#' @return 返回值
#' @export
#'
#' @examples
#' md_costCenter_audit_detail_shared_list()
md_costCenter_audit_detail_shared_list <- function(conn=tsda::conn_rds('jlrds'),
                                              FYear = 2021,
                                              FPeriod =6,
                                              FCostCenter ='20000634'){
  sql <- paste0("select * from rds_vw_md_costCenter_shared
where FCostCenter ='",FCostCenter,"'
and FYear = ",FYear," and FPeriod =  ",FPeriod,"")
  res <- tsda::sql_select(conn,sql)
  return(res)

}













