#' 针对基础资料凭证进行重分类
#'
#' @param conn 连接
#' @param FYear 年份
#' @param FPeriod 期间
#'
#' @return 返回值
#' @export
#'
#' @examples
#' mrpt2_md_costCenter_delete()
mrpt2_md_costCenter_delete <- function(conn=tsda::conn_rds('jlrds'),
                                       FYear =2021,
                                       FPeriod = 6 ) {
  sql <- paste0("delete  from  t_mrpt_md_costCenter2
where FYear = ",FYear," and FPeriod =  ",FPeriod,"")
  tsda::sql_update(conn,sql)
}
#' 针对基础资料凭证进行重分类
#'
#' @param conn 连接
#' @param FYear 年份
#' @param FPeriod 期间
#'
#' @return 返回值
#' @export
#'
#' @examples
#' mrpt2_md_costCenter_taging()
mrpt2_md_costCenter_taging <- function(conn=tsda::conn_rds('jlrds'),
                                       FYear =2021,
                                       FPeriod = 6 ) {
sql <- paste0("select * from  t_mrpt_costCenterRatio_sap
where FYear = ",FYear," and FPeriod =  ",FPeriod,"")
data <- tsda::sql_select(conn,sql)
#添加类型共享与独立
data$FAllocateType[data$FValue == 1] <- '独立'
data$FAllocateType[data$FValue != 1] <- '共享'
#根据类型处理费用分类
data$FFeeType[data$FAllocateType == '独立' & data$FType == '市场'] <- '市场费用待分配'
data$FFeeType[data$FAllocateType == '独立' & data$FType == '渠道'] <- '直接归集费用'
data$FFeeType[data$FAllocateType == '共享' & data$FType == '渠道'
              & (data$FChannel == '自然堂美妆' | data$FChannel =='自然堂商超')] <- '自然堂渠道费用待分配'
data$FFeeType[data$FAllocateType == '共享' & data$FType == '渠道'
              & (data$FChannel == '美素美妆' | data$FChannel =='美素商超')] <- '美素渠道费用待分配'
data$FFeeType[data$FAllocateType == '共享' & data$FType == '渠道'
              & (data$FChannel == '春夏货架' | data$FChannel =='春夏美妆' | data$FChannel =='自然堂货架')] <- '春夏货架渠道费用待分配'
ncount <- nrow(data)
if(ncount >0){
  mrpt2_md_costCenter_delete(conn=conn,FYear = FYear,FPeriod = FPeriod)
  tsda::db_writeTable(conn = conn,table_name = 't_mrpt_md_costCenter2',r_object = data,append = T)

}
return(data)

}
