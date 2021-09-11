#' 管理报表反查数据源SAP凭证
#'
#' @param conn 连接
#' @param FYear 年份
#' @param FPeriod 期间
#' @param FBrand 品牌
#' @param FChannel 渠道
#' @param FRptItemNumber 报表项目代码
#'
#' @return 返回值
#' @export
#'
#' @examples
#' audit_detail_fromDS1_SAP()
audit_detail_fromDS1_SAP <- function(conn=tsda::conn_rds('jlrds'),
                                     FYear = 2021,
                                     FPeriod =6,
                                     FBrand = '美素',
                                     FChannel = '电商',
                                     FRptItemNumber = 'I17'
                                     ) {
  sql <- paste0("select  *
 from mrpt2_vw_trace_sap_detail
 where FYear = ",FYear," and FPeriod = ",FPeriod," and FBrand = '",FBrand,"' and FChannel = '",FChannel,"' and FRptItemNumber='",FRptItemNumber,"'")


# sql <- paste0("select  FYear,FPeriod,FBrand,FChannel,FRptItemNumber,FRptItemName,FActualAmt,
#  FSAP_costCenterCode,FSAP_costElementName,FSAP_voucherNumber,FSAP_vchAmt,
#  FSAP_ChannelFeeRate
#  from rds_vw_T_DETAILFI_RPA_sap
#  where FYear = ",FYear," and FPeriod = ",FPeriod," and FBrand = '",FBrand,"' and FChannel = '",FChannel,"' and FRptItemNumber='",FRptItemNumber,"'")

res <- tsda::sql_select(conn,sql)
return(res)

}



#' 管理报表反查数据源手调凭证
#'
#' @param conn 连接
#' @param FYear 年份
#' @param FPeriod 期间
#' @param FBrand 品牌
#' @param FChannel 渠道
#' @param FRptItemNumber 报表项目代码
#'
#' @return 返回值
#' @export
#'
#' @examples
#' audit_detail_fromDS1_ADJ()
audit_detail_fromDS1_ADJ <- function(conn=tsda::conn_rds('jlrds'),
                                     FYear = 2021,
                                     FPeriod =6,
                                     FBrand = '自然堂',
                                     FChannel = '商超',
                                     FRptItemNumber = 'I21'
) {

  sql <- paste0("select  *
 from mrpt2_vw_trace_adj_detail
 where FYear = ",FYear," and FPeriod = ",FPeriod," and FBrand = '",FBrand,"' and FChannel = '",FChannel,"' and FRptItemNumber='",FRptItemNumber,"'")

 #  sql <- paste0("select  FYear,FPeriod,FBrand,FChannel,FRptItemNumber,FRptItemName,FActualAmt,
 # FSAP_costCenterCode,FSAP_costElementName,FSAP_voucherNumber,FSAP_vchAmt,
 # FSAP_ChannelFeeRate
 # from rds_vw_T_DETAILFI_RPA_adj
 # where FYear = ",FYear," and FPeriod = ",FPeriod," and FBrand = '",FBrand,"' and FChannel = '",FChannel,"' and FRptItemNumber='",FRptItemNumber,"'")
 #
 #
  res <- tsda::sql_select(conn,sql)
  return(res)

}



#' 管理报表反查数据源BW报表
#'
#' @param conn 连接
#' @param FYear 年份
#' @param FPeriod 期间
#' @param FBrand 品牌
#' @param FChannel 渠道
#' @param FRptItemNumber 报表项目代码
#'
#' @return 返回值
#' @export
#'
#' @examples
#' audit_detail_fromDS1_BW()
audit_detail_fromDS1_BW <- function(conn=tsda::conn_rds('jlrds'),
                                     FYear = 2021,
                                     FPeriod =6,
                                     FBrand = '自然堂',
                                     FChannel = '商超',
                                     FRptItemNumber = 'I10'
) {

  sql <- paste0("select *
 from mrpt2_vw_trace_bw_detail
 where FYear = ",FYear," and FPeriod = ",FPeriod," and FBrand = '",FBrand,"' and FChannel = '",FChannel,"' and FRptItemNumber ='",FRptItemNumber,"'")


 #  sql <- paste0("select FYear,FPeriod,FBrand,FChannel,FRptItemNumber_o,FRptItemName,FActualAmt,
 # FSolutionNumber,FSubNumber,FValueType,F13_itemGroupNumber,F13_itemGroupName,
 # F14_brandNumer,F14_brandName,F30_customerNumber,F30_customerName,
 # F33_subChannelNumber,F33_subChannelName,F37_disctrictSaleDeptNumber,F37_disctrictSaleDeptName,
 # F41_channelName,F61_costCenterControlNumber,F61_costCenterControlName
 # from rds_vw_T_DETAILFI_RPA_bw2
 # where FYear = ",FYear," and FPeriod = ",FPeriod," and FBrand = '",FBrand,"' and FChannel = '",FChannel,"' and FRptItemNumber_o='",FRptItemNumber,"'")
 #

  res <- tsda::sql_select(conn,sql)
  return(res)

}




#' 管理报表反查数据源所有过程表
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
#' audit_detail_All()
audit_detail_All <- function(conn=tsda::conn_rds('jlrds'),
                                    FYear = 2021,
                                    FPeriod =6,
                                    FBrand = '自然堂',
                                    FChannel = '商超'

) {

  sql <- paste0("
 select * from  T_DETAILFI_RPA
 where FYear = ",FYear," and FPeriod = ",FPeriod," and FBrand = '",FBrand,"' and FChannel = '",FChannel,"'
                 order by FRptItemNumber ")
  res <- tsda::sql_select(conn,sql)
  return(res)

}
