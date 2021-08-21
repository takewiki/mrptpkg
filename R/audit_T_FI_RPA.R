#' 获取管报结果表的品牌渠道
#'
#' @param conn 连接
#' @param FYear 年
#' @param FPeriod 月
#'
#' @return 返回值
#' @export
#'
#' @examples
#' audit_fi_rpa_brandChannel()
audit_fi_rpa_brandChannel <- function(conn=tsda::conn_rds('jlrds'),
                                      FYear = 2021,
                                      FPeriod =6) {

  sql <- paste0("select FBrand,FChannel  from rds_vw_T_FI_RPA_brandChannel
where FYear = ",FYear," and FPeriod =  ",FPeriod,"
order by FBrand,FChannel")
  res <- tsda::sql_select(conn,sql)
  return(res)

}

#' 审计报表
#'
#' @param conn 连接
#' @param FYear 年份
#' @param FPeriod 期间
#' @param FBrand 品牌
#' @param FChannel 渠道
#'
#' @return 返回值
#' @export
#'
#' @examples
#' audit_fi_rpa_rpt()
audit_fi_rpa_rpt <- function(conn=tsda::conn_rds('jlrds'),
                                      FYear = 2021,
                                      FPeriod =6,
                             FBrand = '美素',
                             FChannel = '电商'
                             ) {

  sql <- paste0("SELECT
      [FBrand]
      ,[FChannel]
      ,[FRptItemNumber]
      ,[FRptItemName]
      ,[FAmt_Manual]
      ,[FAmt_RPA]
      ,[FAmt_Diff]
  FROM [dbo].[rds_vw_T_FI_RPA]
where FYear = ",FYear," and FPeriod = ",FPeriod," and FBrand = '",FBrand,"' and FChannel = '",FChannel,"'
order by FBrand,FChannel,FRptItemNumber")
  res <- tsda::sql_select(conn,sql)
  return(res)

}



