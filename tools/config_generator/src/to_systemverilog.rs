pub trait ToSystemVerilog {
    fn to_systemverilog(&self) -> String;
}

impl ToSystemVerilog for crate::toml_struct::FileContexts {
    fn to_systemverilog(&self) -> String {
        let header = format!(
            "// description: {}\n`ifndef _{}\n`define _{}\n\npackage {};\n",
            self.description,
            self.name.to_uppercase(),
            self.name.to_uppercase(),
            self.name,
        );
        let body = &self.config_type.to_systemverilog();
        let footer = format!("endpackage\n`endif  // _{}\n", self.name.to_uppercase());

        header + &body + &footer
    }
}

impl ToSystemVerilog for crate::toml_struct::ConfigType {
    fn to_systemverilog(&self) -> String {
        match self {
            Self::Exec(params) => params.to_systemverilog(),
            Self::Test(test) => test.to_systemverilog(),
        }
    }
}
impl ToSystemVerilog for crate::toml_struct::Params {
    fn to_systemverilog(&self) -> String {
        let mut body = String::new();
        for (key, value) in &self.int {
            body.push_str(&format!("    parameter int {} = {};\n", key, value));
        }
        for (key, value) in &self.str {
            body.push_str(&format!("    parameter string {} = {};\n", key, value));
        }
        for (key, value) in &self.define {
            body.push_str(&format!("    `define {} {}\n", key, value));
        }
        body
    }
}
impl ToSystemVerilog for crate::toml_struct::Test {
    fn to_systemverilog(&self) -> String {
        let mut body = String::new();
        body.push_str(&self.common.to_systemverilog());
        for test_case in &self.tests {
            body.push_str(&test_case.to_systemverilog());
        }
        body
    }
}
impl ToSystemVerilog for crate::toml_struct::TestCase {
    fn to_systemverilog(&self) -> String {
        let mut body = String::new();
        body.push_str(&self.params.to_systemverilog());
        body
    }
}

#[cfg(test)]
mod test {
    use super::*;
    use crate::toml_struct::*;

    #[test]
    fn file_contexts_serialize() {
        let file_contexts = FileContexts::exec_sample();
        file_contexts.to_systemverilog();
    }

    #[test]
    fn exec_sample_serialize() {
        let file_contexts = FileContexts::test_sample();
        file_contexts.to_systemverilog();
    }

    #[test]
    fn params_serialize() {
        let params = Params::sample();
        params.to_systemverilog();
    }

    #[test]
    fn test_serialize() {
        let test = Test::sample();
        test.to_systemverilog();
    }

    #[test]
    fn test_case_serialize() {
        let test_case = TestCase::sample("test_case");
        test_case.to_systemverilog();
    }
}
