// generated by codegen/codegen.py
import codeql.swift.elements.stmt.BraceStmt
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.decl.VarDecl

class TapExprBase extends @tap_expr, Expr {
  override string toString() { result = "TapExpr" }

  Expr getSubExpr() {
    exists(Expr x |
      tap_expr_sub_exprs(this, x) and
      result = x.resolve()
    )
  }

  VarDecl getVar() {
    exists(VarDecl x |
      tap_exprs(this, x, _) and
      result = x.resolve()
    )
  }

  BraceStmt getBody() {
    exists(BraceStmt x |
      tap_exprs(this, _, x) and
      result = x.resolve()
    )
  }
}
