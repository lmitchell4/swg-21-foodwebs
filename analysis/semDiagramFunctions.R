
## Function to map data field names to pretty labels for diagrams.
createLabels <- function(model_fit, var_name_df) {
  ## model_fit: a lavaan model object.
  ## var_name_df: a copy of the file column_names.csv as a data frame.

  ptab <- lavaan::parameterestimates(model_fit)
  ptab <- subset(ptab, op != ":=") #exclude derived parameters

  uniq_vars <- unique(c(ptab$lhs,ptab$rhs))

  lat_name_df <- data.frame("Shortname"=c("zoop","fish"),
                            "Diagramname"=c("zooplankton","fish\nbiomass"),
                            stringsAsFactors = F)
  varNameMap <- c(var_name_df[,"Diagramname"], lat_name_df[,"Diagramname"])
  names(varNameMap) <- c(var_name_df[,"Shortname"], lat_name_df[,"Shortname"])

  ret <- varNameMap[uniq_vars]
  if(any(is.na(ret))) stop("missing variable name")
  if(any(is.na(names(ret)))) stop("missing labels")
  return(ret)
}

######################################################################################
## Coordinates:

getAnnualCoordinates <- function() {
  x1 <- 1
  x2 <- 3.5

  coordinate_map <- list(
    c("estfish_bsmt",x1 - 1.5,5),
    c("estfish",x1,5),
    c("estfish_stn",x1 + 1.5,5),

    c("fish",x1,4),
    c("pzoop",x1,3),
    c("hzoop",x1,2),
    c("chla",x1,1),

    c("flow",x2,4),
    c("temp",x2,3),
    c("turbid",x2,2),
    c("potam",x2,1),
    c("corbic",x2,1)
  )

  df <- as.data.frame(do.call("rbind", coordinate_map))
  names(df) <- c("Shortname","x","y")
  df$x <- as.numeric(df$x)
  df$y <- as.numeric(df$y)

  ## R2 coordinates outside of the node:
  df$x_R2 <- df$x + 0.4
  df$y_R2 <- df$y - 0.45
  df$y_R2[df$y == max(df$y)] <- df$y[df$y == max(df$y)] + 0.43
  df$x_R2[df$y == max(df$y)] <- df$x[df$y == max(df$y)]

  return(df)
}

getUpperTrophicCoordinates <- function(df) {
  x1 <- 1
  x2 <- 3.5
  x3 <- 6

  coordinate_map <- list(
    c("estfish_bsmt_1",x1,5),
    c("potam_1",x1,4),
    c("pzoop_1",x1,3),
    c("hzoop_1",x1,2),
    c("chla_1",x1,1),

    c("estfish_bsmt",x2,5),
    c("pzoop",x2,3),
    c("hzoop",x2,2),

    c("estfish_bsmt_gr",x2,5),
    c("pzoop_gr",x2,3),
    c("hzoop_gr",x2,2),

    c("marfish_bsmt_1",x3,4),
    c("flow",x3,3),
    c("temp",x3,2),
    c("turbid",x3,1),

    c("corbic_1",x1,4),

    c("sside_1",x3,6),
    c("cent_1",x3,4),
    c("sbass1_bsmt_1",x3,5)
  )

  df <- as.data.frame(do.call("rbind", coordinate_map))
  names(df) <- c("Shortname","x","y")
  df$x <- as.numeric(df$x)
  df$y <- as.numeric(df$y)

  ## R2 coordinates outside of the node:
  df$x_R2 <- df$x - 0.38
  df$y_R2 <- df$y - 0.45

  return(df)
}

getLowerTrophicCoordinates <- function(df) {
  x1 <- 1
  x2 <- 3.5
  x3 <- 6

  coordinate_map <- list(
    c("potam_1",x1,5),
    c("corbic_1",x1,5),
    c("pzoop_1",x1,4),
    c("hzoop_1",x1,3),
    c("chla_1",x1,2),
    c("din_1",x1,1),

    c("potam",x2,5),
    c("corbic",x2,5),
    c("chla",x2,2),
    c("din",x2,1),

    c("potam_gr",x2,5),
    c("corbic_gr",x2,5),
    c("chla_gr",x2,2),
    c("din_gr",x2,1),

    c("flow",x3,4),
    c("temp",x3,3),
    c("turbid",x3,2)
  )

  df <- as.data.frame(do.call("rbind", coordinate_map))
  names(df) <- c("Shortname","x","y")
  df$x <- as.numeric(df$x)
  df$y <- as.numeric(df$y)

  ## R2 coordinates outside of the node:
  df$x_R2 <- df$x - 0.38
  df$y_R2 <- df$y - 0.45

  return(df)
}


getZoopCoordinates <- function(region) {
  x1 <- 1
  x2 <- 3.5
  x3 <- 6

  if(region == "Far West") {
    coordinate_map <- list(
      c("estfish_bsmt_1",x1,6),
      c("pcope_1",x1,5),
      c("hcope_1",x1,4),
      c("amphi_m_1",x1,3),
      c("rotif_m_1",x1,2),
      c("chla_1",x1,1),

      c("estfish_bsmt",x2,6),
      c("pcope",x2,5),
      c("hcope",x2,4),
      c("amphi_m",x2,3),
      c("rotif_m",x2,2),
      c("chla",x2,1),

      c("estfish_bsmt_gr",x2,6),
      c("pcope_gr",x2,5),
      c("hcope_gr",x2,4),
      c("amphi_m_gr",x2,3),
      c("rotif_m_gr",x2,2),
      c("chla_gr",x2,1),

      c("potam_1",x3,5),
      c("flow",x3,4),
      c("temp",x3,3),
      c("turbid",x3,2))

  } else if(region == "West") {
    coordinate_map <- list(
      c("estfish_bsmt_1",x1,7),
      c("mysid_1",x1,6),
      c("pcope_1",x1,5),
      c("hcope_1",x1,4),
      c("amphi_m_1",x1,3),
      c("rotif_m_1",x1,2),
      c("chla_1",x1,1),

      c("estfish_bsmt",x2,7),
      c("mysid",x2,6),
      c("pcope",x2,5),
      c("hcope",x2,4),
      c("amphi_m",x2,3),
      c("rotif_m",x2,2),
      c("chla",x2,1),

      c("estfish_bsmt_gr",x2,7),
      c("mysid_gr",x2,6),
      c("pcope_gr",x2,5),
      c("hcope_gr",x2,4),
      c("amphi_m_gr",x2,3),
      c("rotif_m_gr",x2,2),
      c("chla_gr",x2,1),

      c("potam_1",x3,5),
      c("flow",x3,4),
      c("temp",x3,3),
      c("turbid",x3,2))

  } else if(region == "North") {
    coordinate_map <- list(
      c("estfish_bsmt_1",x1,8),
      c("mysid_1",x1,7),
      c("pcope_1",x1,6),
      c("hcope_1",x1,5),
      c("clad_1",x1,4),
      c("amphi_m_1",x1,3),
      c("rotif_m_1",x1,2),
      c("chla_1",x1,1),

      c("estfish_bsmt",x2,8),
      c("mysid",x2,7),
      c("pcope",x2,6),
      c("hcope",x2,5),
      c("clad",x2,4),
      c("amphi_m",x2,3),
      c("rotif_m",x2,2),
      c("chla",x2,1),

      c("estfish_bsmt_gr",x2,8),
      c("mysid_gr",x2,7),
      c("pcope_gr",x2,6),
      c("hcope_gr",x2,5),
      c("clad_gr",x2,4),
      c("amphi_m_gr",x2,3),
      c("rotif_m_gr",x2,2),
      c("chla_gr",x2,1),

      c("corbic_1",x3,5),
      c("flow",x3,4),
      c("temp",x3,3),
      c("turbid",x3,2))

  } else if(region == "South") {
    coordinate_map <- list(
      c("estfish_bsmt_1",x1,7),
      c("pcope_1",x1,6),
      c("hcope_1",x1,5),
      c("clad_1",x1,4),
      c("amphi_m_1",x1,3),
      c("rotif_m_1",x1,2),
      c("chla_1",x1,1),

      c("estfish_bsmt",x2,7),
      c("pcope",x2,6),
      c("hcope",x2,5),
      c("clad",x2,4),
      c("amphi_m",x2,3),
      c("rotif_m",x2,2),
      c("chla",x2,1),

      c("estfish_bsmt_gr",x2,7),
      c("pcope_gr",x2,6),
      c("hcope_gr",x2,5),
      c("clad_gr",x2,4),
      c("amphi_m_gr",x2,3),
      c("rotif_m_gr",x2,2),
      c("chla_gr",x2,1),

      c("corbic_1",x3,5),
      c("flow",x3,4),
      c("temp",x3,3),
      c("turbid",x3,2))
  }

  df <- as.data.frame(do.call("rbind", coordinate_map))
  names(df) <- c("Shortname","x","y")
  df$x <- as.numeric(df$x)
  df$y <- as.numeric(df$y)

  ## R2 coordinates outside of the node:
  df$x_R2 <- df$x - 0.4
  df$y_R2 <- df$y - 0.4

  return(df)
}

######################################################################################
## Edge options:

getAnnualPortOptions <- function() {
  tmp1 <- expand.grid(from_name=c("flow","temp","turbid","potam","corbic"),
                      to_name=c("fish","pzoop","hzoop","chla"),
                      headport="e",
                      tailport="w")

  tmp2 <- data.frame(from_name=c("chla","hzoop","pzoop"),
                     to_name=c("hzoop","pzoop","fish"),
                     headport="s",
                     tailport="n")

  # tmp3 <- data.frame(from_name=c("chla","hzoop","chla"),
  #                    to_name=c("pzoop","fish","fish"),
  #                    headport="w",
  #                    tailport="w")

  tmp4<- data.frame(from_name=c("fish"),
                    to_name=c("estfish","estfish_stn","estfish_bsmt"),
                    headport="s",
                    tailport="n")

  ret <- do.call("rbind", list(tmp1, tmp2, tmp4))
  for(colname in names(ret)) {
    if(is.factor(ret[ ,colname])) {
      ret[ ,colname] <- as.character(ret[ ,colname])
    }
  }
  stopifnot(sum(duplicated(ret[ ,1:2])) == 0)

  return(ret)
}

getUpperTrophicPortOptions <- function() {
  tmp1 <- expand.grid(from_name=c("estfish_bsmt_1","potam_1","pzoop_1","hzoop_1",
                                  "chla_1","corbic_1"),
                      to_name=c("estfish_bsmt","pzoop","hzoop","estfish_bsmt_gr",
                                "pzoop_gr","hzoop_gr"),
                      headport="w",
                      tailport="e")

  tmp2 <- expand.grid(from_name=c("marfish_bsmt_1","flow","temp","turbid",
                                  "sside_1","cent_1"),
                      to_name=c("estfish_bsmt","pzoop","hzoop","estfish_bsmt_gr",
                                "pzoop_gr","hzoop_gr"),
                      headport="e",
                      tailport="w")

  ret <- do.call("rbind", list(tmp1, tmp2))
  for(colname in names(ret)) {
    if(is.factor(ret[ ,colname])) {
      ret[ ,colname] <- as.character(ret[ ,colname])
    }
  }
  stopifnot(sum(duplicated(ret[ ,1:2])) == 0)

  return(ret)
}

getLowerTrophicPortOptions <- function() {
  tmp1 <- expand.grid(from_name=c("potam_1","pzoop_1","hzoop_1","chla_1","din_1",
                                  "corbic_1"),
                      to_name=c("potam","chla","din","corbic","potam_gr","chla_gr",
                                "din_gr","corbic_gr"),
                      headport="w",
                      tailport="e")

  tmp2 <- expand.grid(from_name=c("flow","temp","turbid"),
                      to_name=c("potam","chla","din","corbic","potam_gr","chla_gr",
                                "din_gr","corbic_gr"),
                      headport="e",
                      tailport="w")

  ret <- do.call("rbind", list(tmp1, tmp2))
  for(colname in names(ret)) {
    if(is.factor(ret[ ,colname])) {
      ret[ ,colname] <- as.character(ret[ ,colname])
    }
  }
  stopifnot(sum(duplicated(ret[ ,1:2])) == 0)

  return(ret)
}

getZoopPortOptions <- function() {
  tmp1 <- expand.grid(from_name=c("pcope_1","hcope_1","amphi_m_1","chla_1","rotif_m_1",
                                  "mysid_1","estfish_bsmt_1","clad_1"),
                      to_name=c("pcope","hcope","amphi_m","chla","mysid","clad",
                                "rotif_m","estfish_bsmt","pcope_gr","hcope_gr",
                                "amphi_m_gr","chla_gr","mysid_gr","clad_gr",
                                "rotif_m_gr","estfish_bsmt_gr"),
                      headport="w",
                      tailport="e")

  tmp2 <- expand.grid(from_name=c("flow","temp","turbid","corbic_1","potam_1"),
                      to_name=c("pcope","hcope","amphi_m","chla","mysid","clad",
                                "rotif_m","estfish_bsmt","pcope_gr","hcope_gr",
                                "amphi_m_gr","chla_gr","mysid_gr","clad_gr",
                                "rotif_m_gr","estfish_bsmt_gr"),
                      headport="e",
                      tailport="w")

  ret <- do.call("rbind", list(tmp1, tmp2))
  for(colname in names(ret)) {
    if(is.factor(ret[ ,colname])) {
      ret[ ,colname] <- as.character(ret[ ,colname])
    }
  }
  stopifnot(sum(duplicated(ret[ ,1:2])) == 0)

  return(ret)
}


######################################################################################
## Nodes and edges:

## For coloring lines according to significance and pos/neg:
colorFcn <- function(pval, coef, sig, col_pos, col_neg, col_ns) {
  stopifnot(length(pval) == length(coef))
  ret <- rep("black", length(pval))

  ## Significant:
  ret[(pval < sig) & (coef > 0)] <- col_pos
  ret[(pval < sig) & (coef < 0)] <- col_neg

  ## Not significant:
  ret[(pval >= sig)] <- col_ns

  return(ret)
}

## For setting line width according to coefficients:
widthFcn <- function(coef, digits) {
  5*(round(abs(coef), digits) + 1/15)
}

getNodes <- function(fit) {
  ## Adapted from the lavaanPlot package:

  fit_std_df <- lavaan::standardizedsolution(fit)

  regress <- fit_std_df$op == "~"
  latent <- fit_std_df$op == "=~"

  observed_nodes <- c()
  latent_nodes <- c()

  if(any(regress)){
    observed_nodes <- c(observed_nodes, unique(fit_std_df$rhs[regress]))
    observed_nodes <- c(observed_nodes, unique(fit_std_df$lhs[regress]))
  }
  if(any(latent)) {
    observed_nodes <- c(observed_nodes, unique(fit_std_df$rhs[latent]))
    latent_nodes <- c(latent_nodes, unique(fit_std_df$lhs[latent]))
  }
  # make sure latent variables don't show up in both
  observed_nodes <- setdiff(observed_nodes, latent_nodes)

  ## Add R2 values:
  R2_df <- data.frame("R2"=round(lavaan::lavInspect(fit, what="rsquare"),3))
  R2_df$Shortname <- row.names(R2_df)
  ## Remove class "lavaan.vector" from the rsquare values after getting names:
  R2_df$R2 <- as.numeric(R2_df$R2)

  ret <- data.frame(Shortname=c(observed_nodes, latent_nodes),
                    var_type=c(rep("observed",length(observed_nodes)),
                               rep("latent",length(latent_nodes)))
  ) %>%
    dplyr::left_join(R2_df, by="Shortname")

  return(ret)
}

getEdges <- function(fit, node_df, sig, digits, col_pos, col_neg, col_ns) {
  ## For mapping from short variable name to node id for creating edges:
  map_node_name_to_id <- node_df$id
  names(map_node_name_to_id) <- node_df$Shortname

  fit_std_df <- lavaan::standardizedsolution(fit)

  ## Create input for edges data frame:
  ret <- fit_std_df %>%
    dplyr::mutate(lhs_id=map_node_name_to_id[lhs],
                  rhs_id=map_node_name_to_id[rhs],
                  pval=ifelse(est.std == 1 & op == "=~", 0, pvalue),
                  var_type=dplyr::case_when(op == "~" ~ "regress",
                                            op == "=~" ~ "latent",
                                            op == "~~" & lhs != rhs ~ "cov"),
                  from_name=dplyr::case_when(var_type == "regress" ~ rhs,
                                             var_type == "latent" ~ lhs,
                                             var_type == "cov" ~ lhs),
                  from_id=dplyr::case_when(var_type == "regress" ~ rhs_id,
                                           var_type == "latent" ~ lhs_id,
                                           var_type == "cov" ~ lhs_id),
                  to_name=dplyr::case_when(var_type == "regress" ~ lhs,
                                           var_type == "latent" ~ rhs,
                                           var_type == "cov" ~ rhs),
                  to_id=dplyr::case_when(var_type == "regress" ~ lhs_id,
                                         var_type == "latent" ~ rhs_id,
                                         var_type == "cov" ~ rhs_id),
                  dir=dplyr::case_when(var_type == "cov" ~ "both"),
                  penwidth=widthFcn(est.std, digits=digits),
                  color=colorFcn(pval=pval, coef=est.std, sig=sig, col_pos, col_neg,
                                 col_ns)) %>%
    dplyr::filter(var_type %in% c("regress","latent","cov"))

  return(ret)
}


######################################################################################
## Graph:

createGraph <- function(fit, reference_df, model_type, region=NULL,
                        title="", cov=FALSE, manual_port_settings=FALSE,
                        addR2Outside=TRUE, addR2Inside=FALSE,
                        sig=0.05, digits=2,
                        line_col_positive="#00B0F0",
                        line_col_negative="red",
                        line_col_notsig="gray60",
                        font_size=16,
                        arrow_size=0.9) {
  ## model_type must be one of the following:
  ##  "annual","monthly_upper_trophic","monthly_lower_trophic","monthly_zoop"

  ## Names come from reference_df.
  ## Coordinates come from coord_input.
  ## Port options come from port_opt_df.

  ## Check reference_df:
  stopifnot(all(c("Shortname","Diagramname") %in% names(reference_df)))
  if(any(is.na(reference_df$Shortname))) {
    stop("At least one Shortname missing in reference_df.")
  }
  reference_df$Diagramname <- ifelse(is.na(reference_df$Diagramname),
                                     reference_df$Shortname,
                                     reference_df$Diagramname)

  ## Get node coordinates and edge preferences:
  if(model_type == "annual") {
    coord_input <- getAnnualCoordinates()
    port_opt_df <- getAnnualPortOptions()
  } else if(model_type == "monthly_upper_trophic") {
    coord_input <- getUpperTrophicCoordinates()
    port_opt_df <- getUpperTrophicPortOptions()
  } else if(model_type == "monthly_lower_trophic") {
    coord_input <- getLowerTrophicCoordinates()
    port_opt_df <- getLowerTrophicPortOptions()
  } else if(model_type == "monthly_zoop") {
    if(is.null(region)) {
      stop("region must be defined for monthly_zoop model")
    }
    coord_input <- getZoopCoordinates(region)
    port_opt_df <- getZoopPortOptions()
  }

  ## Create nodes. Needs to stay in order according to the id column that gets created.
  ## Edge matching apparently occurs by ordering despite the id column.
  node_input_df <- getNodes(fit) %>%
    dplyr::left_join(reference_df, by="Shortname") %>%
    dplyr::left_join(coord_input, by="Shortname")

  stopifnot(all(node_input_df$node %in% reference_df$Shortname))
  if(any(is.na(node_input_df[ ,c("x","y")]))) {
    print(node_input_df)
    stop("Missing value(s) of x and/or y.")
  }
  if(any(duplicated(node_input_df[ ,c("x","y")]))) {
    print(node_input_df)
    stop("Duplicated coordinates.")
  }

  if(addR2Inside) {
    node_input_df <- node_input_df %>%
      dplyr::mutate(label=ifelse(is.na(R2), Diagramname,
                                  sprintf("%s\n(%s)",Diagramname,R2)))
  } else {
    node_input_df <- node_input_df %>%
      dplyr::mutate(label=Diagramname)
  }

  node_df <- DiagrammeR::create_node_df(
    n=nrow(node_input_df),
    label=node_input_df$label,
    Shortname=node_input_df$Shortname,
    x=node_input_df$x,
    y=node_input_df$y,
    fontcolor="white",
    color=node_input_df$Color,
    fillcolor=node_input_df$Color,
    shape=dplyr::case_when(node_input_df$var_type == "observed" ~ "polygon",
                           node_input_df$var_type == "latent" ~ "ellipse"),
    width=1,
    fixedsize=FALSE,
    fontsize=font_size)

  ## For R2 outside the nodes:
  R2_input_df <- node_input_df %>%
    dplyr::filter(!is.na(R2))
  R2_node_df <- DiagrammeR::create_node_df(
    n=nrow(R2_input_df),
    label=R2_input_df$R2,
    Shortname=R2_input_df$Shortname,
    x=R2_input_df$x_R2,
    y=R2_input_df$y_R2,
    fontcolor="black",
    color="#FFFFFF00",  # use transparency to prevent a shadow
    fillcolor="#FFFFFF00",  # use transparency to prevent a shadow
    style="filled",
    shape="ellipse",
    penwidth=0,
    width=0.4,
    height=0.2,
    fixedsize=TRUE,
    fontsize=font_size)
  R2_node_df$id <- R2_node_df$id + nrow(node_df)

  ## Create edges:
  edge_input_df <- getEdges(fit, node_df, sig=sig, digits=digits,
                            col_pos=line_col_positive, col_neg=line_col_negative,
                            col_ns=line_col_notsig)
  if(!cov) {
    edge_input_df <- subset(edge_input_df, var_type != "cov")
  }

  if(manual_port_settings) {
    edge_input_df <- edge_input_df %>%
      dplyr::left_join(port_opt_df, by=c("from_name","to_name"))
  } else {
    edge_input_df <- edge_input_df %>%
      dplyr::mutate(headport=NA, tailport=NA)
  }
  stopifnot(all(edge_input_df$lhs_ok) && all(edge_input_df$rhs_ok))

  edges_df <- DiagrammeR::create_edge_df(
    from=edge_input_df$from_id,
    to=edge_input_df$to_id,
    from_name=edge_input_df$from_name,
    to_name=edge_input_df$to_name,
    penwidth=edge_input_df$penwidth,
    color=edge_input_df$color,
    dir=edge_input_df$dir,
    headport=edge_input_df$headport,
    tailport=edge_input_df$tailport,
    arrowsize=arrow_size)

  ## Create graph:
  graph <- DiagrammeR::create_graph() %>%
    DiagrammeR::add_node_df(node_df=node_df) %>%
    DiagrammeR::add_edge_df(edge_df=edges_df) %>%
    DiagrammeR::add_global_graph_attrs(attr="splines",
                                       value="spline",
                                       attr_type="graph") %>%
    DiagrammeR::add_global_graph_attrs(attr="bgcolor",
                                       value="transparent",
                                       attr_type="graph")
  if(addR2Outside) {
    graph <- graph %>%
      DiagrammeR::add_node_df(R2_node_df)
  }

  graph <- graph %>%
    DiagrammeR::render_graph(title=title)

  return(graph)
}


convert_html_to_grob = function(html_input, resolution){

  temp_name = "temp.png"

  html_input %>%
    export_svg %>%
    charToRaw %>%
    rsvg_png("temp.png", height = resolution)

  out_grob = rasterGrob(readPNG("temp.png", native = FALSE))

  file.remove("temp.png")
  return(out_grob)
}


######################################################################################
## Older functions for creating SEM diagrams:

## Directly taken and modified from the lavaanPlot package:
## https://github.com/alishinski/lavaanPlot

## https://rich-iannone.github.io/DiagrammeR/graphviz_and_mermaid.html
## https://rich-iannone.github.io/DiagrammeR/ndfs_edfs.html
## https://bookdown.org/yihui/rmarkdown-cookbook/diagrams.html


#' Plots lavaan path model with DiagrammeR
#'
#' @param name A string of the name of the plot.
#' @param model A model fit object of class lavaan.
#' @param labels  An optional named list of variable labels.
#' @param ... Additional arguments to be called to \code{buildCall} and \code{buildPaths}
#' @return A Diagrammer plot of the path diagram for \code{model}
#' @importFrom DiagrammeR grViz
#' @export
#' @examples
#' library(lavaan)
#' model <- 'mpg ~ cyl + disp + hp
#'           qsec ~ disp + hp + wt'
#' fit <- sem(model, data = mtcars)
#' lavaanPlot(model = fit, node_options = list(shape = "box", fontname = "Helvetica"),
#'  edge_options = list(color = "grey"), coefs = FALSE)
myLavaanPlot <- function(name = "plot", model, labels = NULL, ...) {

  #' Builds the Diagrammer function call.
  #'
  #' @param name A string of the name of the plot.
  #' @param model A model fit object of class lavaan.
  #' @param labels  An optional named list of variable labels fit object of class lavaan.
  #' @param graph_options  A named list of graph options for Diagrammer syntax.
  #' @param node_options  A named list of node options for Diagrammer syntax.
  #' @param edge_options  A named list of edge options for Diagrammer syntax.
  #' @param ... additional arguments to be passed to \code{buildPaths}
  #' @return A string specifying the path diagram for \code{model}
  buildCall <- function(name = name, model = model, labels = labels, graph_options = list(overlap = "true", fontsize = "10"), node_options = list(shape = "box"), edge_options = list(color = "black"), ...){
    string <- ""
    string <- paste(string, "digraph", name, "{")
    string <- paste(string, "\n")
    string <- paste(string, "graph", "[",  paste(paste(names(graph_options), graph_options, sep = " = "), collapse = ", "), "]")
    string <- paste(string, "\n")
    string <- paste(string, "node", "[", paste(paste(names(node_options), node_options, sep = " = "), collapse = ", "), "]")
    string <- paste(string, "\n")
    nodes <- getNodes(model)
    string <- paste(string, "node [shape = box] \n")
    string <- paste(string, paste(nodes$observeds, collapse = "; "))
    string <- paste(string, "\n")
    string <- paste(string, "node [shape = oval] \n")
    string <- paste(string, paste(nodes$latents, collapse = "; "))
    string <- paste(string, "\n")
    if(!is.null(labels)){
      labels_string = buildLabels(labels)
      string <- paste(string, labels_string)
    }
    string <- paste(string, "\n")
    string <- paste(string, "edge", "[", paste(paste(names(edge_options), edge_options, sep = " = "), collapse = ", "), "]")
    string <- paste(string, "\n")
    string <- paste(string, buildPaths(model, ...))
    string <- paste(string, "}", sep = "\n")
    string
  }

  #' Extracts the paths from the lavaan model.
  #'
  #' @param fit A model fit object of class lavaan.
  #' @param coefs whether or not to include significant path coefficient values in diagram
  #' @param sig significance level for determining what significant paths are
  #' @param stand Should the coefficients being used be standardized coefficients
  #' @param covs Should model covariances be included in the diagram
  #' @param stars a character vector indicating which parameters should include significance stars be included for regression paths, latent paths, or covariances. Include which of the 3 you want ("regress", "latent", "covs"), default is none.
  #' @param digits A number indicating the desired number of digits for the coefficient values in the plot
  #' @importFrom stringr str_replace_all
  buildPaths <- function(fit, coefs=FALSE, sig=1.00, stand=FALSE, covs=FALSE, stars=NULL,
                         width=NULL, color=NULL, digits=2) {
    if(stand){
      ParTable <- lavaan::standardizedsolution(fit)
      ParTableAlt <- fit@ParTable
    } else {
      ParTable <- fit@ParTable
      ParTableAlt <- fit@ParTable
    }

    # get rid of . from variable names
    ParTable$lhs <- stringr::str_replace_all(fit@ParTable$lhs, pattern = "\\.",
                                             replacement = "")
    ParTable$rhs <- stringr::str_replace_all(fit@ParTable$rhs, pattern = "\\.",
                                             replacement = "")

    regress <- ParTable$op == "~"
    latent <- ParTable$op == "=~"
    #cov <- ParTable$op == "~~" & (ParTable$rhs %in% ParTable$lhs[latent | regress]) & (ParTable$rhs != ParTable$lhs)
    cov <- ParTable$op == "~~" & (ParTable$rhs != ParTable$lhs)

    colorFcn <- function(x) { ifelse(x > 0, "Green4", "Red3") }
    widthFcn <- function(x) { ifelse(x, 3, 1) }

    zval_reg <- ParTableAlt$est[regress] / ParTableAlt$se[regress]
    pval_reg <- (1 - stats::pnorm(abs(zval_reg))) * 2
    signif_reg <- pval_reg < sig
    coef <- ifelse(signif_reg, round(ParTable$est[regress], digits = digits), "")

    pos_reg <- colorFcn(ParTable$est[regress])
    width_reg <- widthFcn(signif_reg)

    zval_lat <- ParTableAlt$est[latent] / ParTableAlt$se[latent]
    pval_lat <- (1 - stats::pnorm(abs(zval_lat))) * 2
    signif_lat <- pval_lat < sig
    latent_coef <- ifelse(signif_lat, round(ParTable$est[latent], digits = digits), "")

    pos_lat <- colorFcn(ParTable$est[latent])
    width_lat <- widthFcn(signif_lat)

    zval_cov <- ParTableAlt$est[cov] / ParTableAlt$se[cov]
    pval_cov <- (1 - stats::pnorm(abs(zval_cov))) * 2
    signif_cov <- pval_cov < sig
    cov_vals <- ifelse(signif_cov, round(ParTable$est[cov], digits = digits), "")

    pos_cov <- colorFcn(ParTable$est[cov])
    width_cov <- widthFcn(signif_cov)

    if("regress" %in% stars){
      #pval_reg <- ParTable$pvalue[regress]
      stars_reg <- unlist(lapply(X = pval_reg, FUN = sig_stars))
    } else {
      stars_reg <- ""
    }

    if("latent" %in% stars){
      #pval_lat <- ParTable$pvalue[latent]
      stars_lat <- unlist(lapply(X = pval_lat, FUN = sig_stars))
    } else {
      stars_lat <- ""
    }

    if("covs" %in% stars){
      #pval_cov <- ParTable$pvalue[cov]
      stars_cov <- unlist(lapply(X = pval_cov, FUN = sig_stars))
    } else {
      stars_cov <- ""
    }

    ##########################################################
    ## My additions

    ## Line widths:
    if("regress" %in% width){
      widths_reg <- paste("penwidth =",width_reg)
    } else {
      widths_reg <- ""
    }

    if("latent" %in% width){
      widths_lat <- paste("penwidth =",width_lat)
    } else {
      widths_lat <- ""
    }

    if("covs" %in% width){
      widths_cov <- paste("penwidth =",width_cov)
    } else {
      widths_cov <- ""
    }

    ## Line colors:
    if("regress" %in% color){
      colors_reg <- paste("color =",pos_reg)
    } else {
      colors_reg <- ""
    }

    if("latent" %in% color){
      colors_lat <- paste("color =",pos_lat)
    } else {
      colors_lat <- ""
    }

    if("covs" %in% color){
      colors_cov <- paste("color =",pos_cov)
    } else {
      colors_cov <- ""
    }
    ##########################################################


    #penwidths <- ifelse(coefs == "", 1, 2)
    if(any(regress)){
      if(coefs){
        regress_paths <- paste(paste(ParTable$rhs[regress], ParTable$lhs[regress], sep = "->"), paste("[label = '", coef, stars_reg, "' ", widths_reg, colors_reg, "]", sep = ""), collapse = " ")
      } else {
        regress_paths <- paste(paste(ParTable$rhs[regress], ParTable$lhs[regress], sep = "->"), collapse = " ")
      }
    } else {
      regress_paths <- ""
    }
    if(any(latent)) {
      if(coefs){
        latent_paths <- paste(paste(ParTable$lhs[latent], ParTable$rhs[latent], sep = "->"), paste("[label = '", latent_coef, stars_lat, "' ", widths_lat, colors_lat, "]", sep = ""), collapse = " ")
      } else {
        latent_paths <- paste(paste(ParTable$lhs[latent], ParTable$rhs[latent], sep = "->"), collapse = " ")
      }
    } else {
      latent_paths <- ""
    }
    if(any(cov)){
      if(covs){

        covVals <- round(ParTable$est[cov], digits = 2)
        if(coefs) {
          cov_paths <- paste(
            paste(
              ParTable$rhs[cov],
              ParTable$lhs[cov], sep = " -> "),
            paste("[label = '", cov_vals, stars_cov, "' ", widths_cov, colors_cov, ", dir = 'both']", sep = ""),
            collapse = " "
          )
        } else {
          cov_paths <- paste(
            paste(
              ParTable$rhs[cov],
              ParTable$lhs[cov], sep = " -> "),
            paste("[dir = 'both']", sep = ""),
            collapse = " "
          )
        }

      } else {
        cov_paths <- ""
      }
    } else {
      cov_paths <- ""
    }
    paste(regress_paths, latent_paths, cov_paths, sep = " ")
  }

  #' Extracts the paths from the lavaan model.
  #'
  #' @param fit A model fit object of class lavaan.
  getNodes <- function(fit){
    # remove . from variable names
    regress <- fit@ParTable$op == "~"
    latent <- fit@ParTable$op == "=~"
    observed_nodes <- c()
    latent_nodes <- c()
    if(any(regress)){
      observed_nodes <- c(observed_nodes, unique(fit@ParTable$rhs[regress]))
      observed_nodes <- c(observed_nodes, unique(fit@ParTable$lhs[regress]))
    }
    if(any(latent)) {
      observed_nodes <- c(observed_nodes, unique(fit@ParTable$rhs[latent]))
      latent_nodes <- c(latent_nodes, unique(fit@ParTable$lhs[latent]))
    }
    # make sure latent variables don't show up in both
    observed_nodes <- setdiff(observed_nodes, latent_nodes)

    # remove . from variable names
    observed_nodes <- stringr::str_replace_all(observed_nodes, pattern = "\\.", replacement = "")
    latent_nodes <- stringr::str_replace_all(latent_nodes, pattern = "\\.", replacement = "")

    list(observeds = observed_nodes, latents = latent_nodes)
  }

  #' Generates standard significance stars
  #'
  #' @param pvals a vector of p values
  sig_stars <- function(pvals){
    if(pvals <= 0.001){
      star = "***"
    } else if (pvals <= 0.01){
      star = "**"
    } else if (pvals <= 0.05){
      star = "*"
    } else {
      star = ""
    }
    star
  }

  #' Adds variable labels to the Diagrammer plot function call.
  #'
  #' @param label_list A named list of variable labels.
  buildLabels <- function(label_list){
    names(label_list) <- stringr::str_replace_all(names(label_list), pattern = "\\.", replacement = "")
    labs <- paste(names(label_list), " [label = ", "'", label_list, "'", "]", sep = "")
    paste(labs, collapse = "\n")
  }

  plotCall <- buildCall(name = name, model = model, labels = labels, ...)
  DiagrammeR::grViz(plotCall)
}

