% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/audit_md.R
\name{md_costItem_audit_detail}
\alias{md_costItem_audit_detail}
\title{查看成本要素明细内容}
\usage{
md_costItem_audit_detail(
  conn = tsda::conn_rds("jlrds"),
  FYear = 2021,
  FPeriod = 6,
  FFeeName = ""
)
}
\arguments{
\item{conn}{连接}

\item{FYear}{年份}

\item{FPeriod}{月份}

\item{FFeeName}{统一费用名称名称}
}
\value{
返回值
}
\description{
查看成本要素明细内容
}
\examples{
md_costItem_audit_detail()
}
