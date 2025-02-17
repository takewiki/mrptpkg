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
#' @param FOnlyError 是否只显示差异
#' @param FErrorValue 允许的差异值，针对差异取绝对值
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
                             FChannel = '电商',
                             FOnlyError = FALSE,
                             FErrorValue = 0.1
                             ) {

  if( FOnlyError){
    #只显示差异部分
    sql <- paste0("SELECT
      [FBrand]
      ,[FChannel]
      ,a.[FRptItemNumber]
      ,a.[FRptItemName]
      ,[FAmt_Manual]
      ,[FAmt_RPA]
      ,[FAmt_Diff]
      ,FRptAmt_orginal
      ,fremark,
      a.FTotalAmt_SAP,a.FTotalAmt_BW,a.FTotalAmt_ADJ,a.FTotalAmt_Top2,a.FTotalAmt_Top3
  FROM [dbo].[t_mrpt_diff_all] a
  inner join t_mrpt_rptItem b
  on a.FRptItemNumber = b.FRptItemNumber
where FYear = ",FYear," and FPeriod = ",FPeriod," and FBrand = '",FBrand,"' and FChannel = '",FChannel,"'
and  b.FDetail = 1
and abs(FAmt_Diff) >= ",FErrorValue,"
order by FBrand,FChannel,FRptItemNumber")

  }else{
    #显示全部
    sql <- paste0("SELECT
      [FBrand]
      ,[FChannel]
      ,[FRptItemNumber]
      ,[FRptItemName]
      ,[FAmt_Manual]
      ,[FAmt_RPA]
      ,[FAmt_Diff]
      ,FRptAmt_orginal
      ,fremark,
      FTotalAmt_SAP,FTotalAmt_BW,FTotalAmt_ADJ,FTotalAmt_Top2,FTotalAmt_Top3
  FROM [dbo].[t_mrpt_diff_all]
where FYear = ",FYear," and FPeriod = ",FPeriod," and FBrand = '",FBrand,"' and FChannel = '",FChannel,"'
order by FBrand,FChannel,FRptItemNumber")

  }



  res <- tsda::sql_select(conn,sql)
  return(res)

}




#' 审计报表进行备注查询
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
#' audit_fi_rpa_getValue()
audit_fi_rpa_getValue <- function(conn=tsda::conn_rds('jlrds'),
                             FYear = 2021,
                             FPeriod =6,
                             FBrand = 'COMO',
                             FChannel = '电商' ,
                             FRptItemNumber='I01'
) {

  sql <- paste0("select FRptAmt,FRemark  from t_mrpt_target
where Fyear = ",FYear,"  and Fperiod = ",FPeriod," and
Fbrand = '",FBrand,"' and Fchannel = '",FChannel,"'
and FRptItemNumber = '",FRptItemNumber,"'")
  res <- tsda::sql_select(conn,sql)
  FRemark <- tsdo::na_replace(res$FRemark,'')
  FRptAmt <- as.numeric(res$FRptAmt)
  info <- list(FRptAmt,FRemark)
  names(info) <- c('FRptAmt','FRemark')
  return(info)

}

#' 审计报表进行备注查询
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
#' audit_fi_rpa_getValue()
audit_fi_rpa_setValue <- function(conn=tsda::conn_rds('jlrds'),
                                  FYear = 2021,
                                  FPeriod =6,
                                  FBrand = 'COMO',
                                  FChannel = '电商' ,
                                  FRptItemNumber='I01',
                                  FRptAmt = 1.08,
                                  FRemark ='S009方案的BW报表缺少F30客户维度，RPA重新取数'

) {

  sql <- paste0("update a set a.FRptAmt = ",FRptAmt,",a.FRemark = '",FRemark,"'  from t_mrpt_target a
where Fyear = ",FYear,"  and Fperiod = ",FPeriod," and
Fbrand = '",FBrand,"' and Fchannel = '",FChannel,"'
and FRptItemNumber = '",FRptItemNumber,"'")
   tsda::sql_update(conn,sql)


}



