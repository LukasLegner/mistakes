interval <- function(l, u) {
  sprintf("$(%s, %s)$", round(l, 2), round(u, 2))
}

hook(interval(.Lower, .Upper), c(.Lower, .Upper))