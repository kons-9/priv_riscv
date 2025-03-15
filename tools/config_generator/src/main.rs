use config_generator::toml_struct::FileContexts;
use config_generator::to_systemverilog::ToSystemVerilog;

fn main() {
    let toml_path = "config.toml";
    let toml_str = std::fs::read_to_string(toml_path).unwrap();
    let file_contexts: FileContexts = toml::from_str(&toml_str).unwrap();
    let file_path = file_contexts.get_filepath();
    std::fs::create_dir_all(file_path.parent().unwrap()).unwrap();
    std::fs::write(&file_path, file_contexts.to_systemverilog()).unwrap();
}
