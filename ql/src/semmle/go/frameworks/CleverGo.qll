/**
 * Provides classes for working with concepts from the [`clevergo.tech/clevergo@v0.5.2`](https://pkg.go.dev/clevergo.tech/clevergo@v0.5.2) package.
 */

import go

/**
 * Provides classes for working with concepts from the [`clevergo.tech/clevergo@v0.5.2`](https://pkg.go.dev/clevergo.tech/clevergo@v0.5.2) package.
 */
private module CleverGo {
  /** Gets the package path. */
  bindingset[result]
  string packagePath() {
    result = package(["clevergo.tech/clevergo", "github.com/clevergo/clevergo"], "")
  }

  /**
   * Provides models of untrusted flow sources.
   */
  private class UntrustedSources extends UntrustedFlowSource::Range {
    UntrustedSources() {
      // Methods on types of package: clevergo.tech/clevergo@v0.5.2
      exists(string receiverName, string methodName, Method mtd, FunctionOutput outp |
        this = outp.getExitNode(mtd.getACall()) and
        mtd.hasQualifiedName(packagePath(), receiverName, methodName)
      |
        receiverName = "Context" and
        (
          // Method: func (*Context).BasicAuth() (username string, password string, ok bool)
          methodName = "BasicAuth" and
          outp.isResult([0, 1])
          or
          // Method: func (*Context).Decode(v interface{}) (err error)
          methodName = "Decode" and
          outp.isParameter(0)
          or
          // Method: func (*Context).DefaultQuery(key string, defaultVlue string) string
          methodName = "DefaultQuery" and
          outp.isResult()
          or
          // Method: func (*Context).FormValue(key string) string
          methodName = "FormValue" and
          outp.isResult()
          or
          // Method: func (*Context).GetHeader(name string) string
          methodName = "GetHeader" and
          outp.isResult()
          or
          // Method: func (*Context).PostFormValue(key string) string
          methodName = "PostFormValue" and
          outp.isResult()
          or
          // Method: func (*Context).QueryParam(key string) string
          methodName = "QueryParam" and
          outp.isResult()
          or
          // Method: func (*Context).QueryString() string
          methodName = "QueryString" and
          outp.isResult()
        )
        or
        receiverName = "Params" and
        (
          // Method: func (Params).String(name string) string
          methodName = "String" and
          outp.isResult()
        )
      )
      or
      // Interfaces of package: clevergo.tech/clevergo@v0.5.2
      exists(string interfaceName, string methodName, Method mtd, FunctionOutput outp |
        this = outp.getExitNode(mtd.getACall()) and
        mtd.implements(packagePath(), interfaceName, methodName)
      |
        interfaceName = "Decoder" and
        (
          // Method: func (Decoder).Decode(req *net/http.Request, v interface{}) error
          methodName = "Decode" and
          outp.isParameter(1)
        )
      )
      or
      // Structs of package: clevergo.tech/clevergo@v0.5.2
      exists(string structName, string fields, DataFlow::Field fld |
        this = fld.getARead() and
        fld.hasQualifiedName(packagePath(), structName, fields)
      |
        structName = "Context" and
        fields = "Params"
        or
        structName = "Param" and
        fields = ["Value", "Key"]
      )
      or
      // Types of package: clevergo.tech/clevergo@v0.5.2
      exists(ValueEntity v | v.getType().hasQualifiedName(packagePath(), "Params") |
        this = v.getARead()
      )
    }
  }

  // Models taint-tracking through functions.
  private class TaintTrackingFunctionModels extends TaintTracking::FunctionModel {
    FunctionInput inp;
    FunctionOutput out;

    TaintTrackingFunctionModels() {
      // Taint-tracking models for package: clevergo.tech/clevergo@v0.5.2
      (
        // Function: func CleanPath(p string) string
        this.hasQualifiedName(packagePath(), "CleanPath") and
        inp.isParameter(0) and
        out.isResult()
      )
    }

    override predicate hasTaintFlow(FunctionInput input, FunctionOutput output) {
      input = inp and output = out
    }
  }

  // Models taint-tracking through method calls.
  private class TaintTrackingMethodModels extends TaintTracking::FunctionModel, Method {
    FunctionInput inp;
    FunctionOutput out;

    TaintTrackingMethodModels() {
      // Taint-tracking models for package: clevergo.tech/clevergo@v0.5.2
      (
        // Receiver: Application
        // Method: func (*Application).RouteURL(name string, args ...string) (*net/url.URL, error)
        this.hasQualifiedName(packagePath(), "Application", "RouteURL") and
        inp.isParameter(_) and
        out.isResult(0)
        or
        // Receiver: Decoder
        // Method: func (Decoder).Decode(req *net/http.Request, v interface{}) error
        this.implements(packagePath(), "Decoder", "Decode") and
        inp.isParameter(0) and
        out.isParameter(1)
        or
        // Receiver: Renderer
        // Method: func (Renderer).Render(w io.Writer, name string, data interface{}, c *Context) error
        this.implements(packagePath(), "Renderer", "Render") and
        inp.isParameter(2) and
        out.isParameter(0)
      )
    }

    override predicate hasTaintFlow(FunctionInput input, FunctionOutput output) {
      input = inp and output = out
    }
  }
}
