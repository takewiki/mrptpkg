#' 反查BW规则表
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
#' audit_rule_bw()
audit_rule_bw <- function(conn=tsda::conn_rds('jlrds'),
                                     FYear = 2021,
                                     FPeriod =9,
                                     FBrand = '珀芙研',
                                     FChannel = '药房',
                                     FRptItemNumber = 'I04'
){

sql <- paste0(" select * from  t_mrpt_rule_bw2
 where FYear = ",FYear," and FPeriod = ",FPeriod,"
 and  FBrand ='",FBrand,"' and FChannel ='",FChannel,"'
 and  FRptItemNumber ='",FRptItemNumber,"'")
data = tsda::sql_select(conn,sql)
ncount =nrow(data)
if(ncount >0){
  names(data) <- c('方案号'	,
                  '方案序号',
                  '13物料组(物料主数据)-名称-包含',
                  '13物料组(物料主数据)-名称-排除',
                  '14品牌(物料主数据)-名称-包含',
                  '14品牌(物料主数据)-名称-排除',
                  '30客户-代码-包含',
                  '30客户-代码-排除',
                  '33子渠道（SAP客户组）(客户主数据)-名称-包含',
                  '33子渠道（SAP客户组）(客户主数据)-名称-排除'	,
                  '37地区销售部(客户主数据)-名称-包含',
                  '37地区销售部(客户主数据)-名称-排除',
                  '41渠道(分析用)-名称-包含',
                  '41渠道(分析用)-名称-排除',
                  '61成本中心(控制)-代码-包含',
                  '61成本中心(控制)-代码-排除',
                  '指标名称',
                  '品牌',
                  '渠道',
                  '报表项目代码',
                  '报表项目名称',
                  '分配比例',
                  '年份',
                  '月份',
                  '方案名称',
                  '方案描述')
}
return(data)


}
