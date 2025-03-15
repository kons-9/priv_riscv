mod toml_struct;
use toml_struct::FileContexts;

pub fn system_verilog_output(toml_path: impl AsRef<std::path::Path>) {
    let toml_str = std::fs::read_to_string(toml_path).unwrap();
    let file_contexts: FileContexts = toml::from_str(&toml_str).unwrap();
    let file_path = file_contexts.get_filepath();
    std::fs::create_dir_all(file_path.parent().unwrap()).unwrap();
    std::fs::write(&file_path, file_contexts.to_systemverilog()).unwrap();
}
