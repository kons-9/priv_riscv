use std::{any::TypeId, path::PathBuf};

use serde::{Deserialize, Serialize, Serializer};
use toml::{map::Map, Value};

#[derive(Serialize, Deserialize, Debug, PartialEq)]
pub struct FileContexts {
    pub(crate) name: String,
    pub(crate) extension: String,
    pub(crate) description: String,
    #[serde(flatten)]
    pub(crate) config_type: ConfigType,
}

impl FileContexts {
    pub fn get_filepath(&self) -> PathBuf {
        let filename = format!("{}.{}", self.name, self.extension);
        match self.config_type {
            ConfigType::Exec(_) => PathBuf::from("arch").join(filename),
            ConfigType::Test(_) => PathBuf::from("include").join(filename),
        }
    }
}

#[derive(Serialize, Deserialize, Debug, PartialEq)]
#[serde(untagged)]
pub(crate) enum ConfigType {
    Exec(Params),
    Test(Test),
}

#[derive(Debug, PartialEq)]
pub(crate) struct Params {
    pub(crate) int: Map<String, Value>,
    pub(crate) str: Map<String, Value>,
    pub(crate) define: Map<String, Value>,
}

impl Serialize for Params {
    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: Serializer,
    {
        if !self.check() {
            return Err(serde::ser::Error::custom("Invalid Params"));
        }
        let mut map = Map::new();
        map.extend(Map::from_iter(vec![
            ("int".to_string(), Value::Table(self.int.clone())),
            ("str".to_string(), Value::Table(self.str.clone())),
            ("define".to_string(), Value::Table(self.define.clone())),
        ]));
        map.serialize(serializer)
    }
}

impl<'de> Deserialize<'de> for Params {
    fn deserialize<D>(deserializer: D) -> Result<Self, D::Error>
    where
        D: serde::Deserializer<'de>,
    {
        let map = Map::deserialize(deserializer)?;
        let params = Params {
            int: {
                let res = map.get("int").and_then(|v| v.as_table().cloned());
                if res.is_none() {
                    return Err(serde::de::Error::custom("Invalid Params"));
                }
                res.unwrap()
            },
            str: {
                let res = map.get("str").and_then(|v| v.as_table().cloned());
                if res.is_none() {
                    return Err(serde::de::Error::custom("Invalid Params"));
                }
                res.unwrap()
            },
            define: {
                let res = map.get("define").and_then(|v| v.as_table().cloned());
                if res.is_none() {
                    return Err(serde::de::Error::custom("Invalid Params"));
                }
                res.unwrap()
            },
        };
        if !params.check() {
            return Err(serde::de::Error::custom("Invalid Params"));
        }
        Ok(params)
    }
}

impl Params {
    fn check_map<T: 'static>(map: &Map<String, Value>) -> bool {
        map.iter().all(|(_, value)| match value {
            Value::Integer(_) => TypeId::of::<T>() == TypeId::of::<i64>(),
            Value::Float(_) => TypeId::of::<T>() == TypeId::of::<f64>(),
            Value::String(_) => TypeId::of::<T>() == TypeId::of::<String>(),
            Value::Boolean(_) => TypeId::of::<T>() == TypeId::of::<bool>(),
            _ => false,
        })
    }
    fn check(&self) -> bool {
        if !Self::check_map::<i64>(&self.int) {
            return false;
        }
        if !Self::check_map::<String>(&self.str) {
            return false;
        }
        if !Self::check_map::<String>(&self.define) {
            return false;
        }
        return true;
    }
}

#[derive(Serialize, Deserialize, Debug, PartialEq)]
pub(crate) struct Test {
    pub(crate) common: Params,
    pub(crate) tests: Vec<TestCase>,
}

#[derive(Serialize, Deserialize, Debug, PartialEq)]
pub(crate) struct TestCase {
    pub(crate) name: String,
    #[serde(flatten)]
    pub(crate) params: Params,
}

#[cfg(test)]
mod test {
    use super::*;
    impl FileContexts {
        pub fn to_toml(&self) -> String {
            toml::to_string(self).unwrap()
        }
        pub fn exec_sample() -> Self {
            FileContexts {
                name: "exec_sample".to_string(),
                extension: "svh".to_string(),
                description: "sample exec".to_string(),
                config_type: ConfigType::Exec(Params::sample()),
            }
        }
        pub fn test_sample() -> Self {
            FileContexts {
                name: "test_sample".to_string(),
                extension: "svh".to_string(),
                description: "sample test".to_string(),
                config_type: ConfigType::Test(Test::sample()),
            }
        }
    }
    impl Params {
        pub fn sample() -> Self {
            let params = Params {
                int: {
                    let mut map = Map::new();
                    map.insert("NUM1".to_string(), Value::from(57));
                    map.insert("NUM2".to_string(), Value::from(57));
                    map
                },
                str: {
                    let mut map = Map::new();
                    map.insert("STR1".to_string(), Value::from("Hello, World!"));
                    map.insert("STR2".to_string(), Value::from("Hello, World!"));
                    map
                },
                define: {
                    let mut map = Map::new();
                    map.insert("DEF1".to_string(), Value::from("Hello, World!"));
                    map.insert("DEF2".to_string(), Value::from("Hello, World!"));
                    map
                },
            };
            assert!(params.check());
            params
        }
    }

    impl Test {
        pub fn sample() -> Self {
            Test {
                common: Params::sample(),
                tests: vec![TestCase::sample("test1"), TestCase::sample("test2")],
            }
        }
    }
    impl TestCase {
        pub fn sample(name: &str) -> Self {
            TestCase {
                name: name.to_string(),
                params: Params::sample(),
            }
        }
    }

    #[test]
    fn exec_serialize() {
        let file_contexts: FileContexts = FileContexts {
            name: "file_name".to_string(),
            extension: "svh".to_string(),
            description: "SystemVerilog Header File".to_string(),
            config_type: ConfigType::Exec(Params {
                int: {
                    let mut map = Map::new();
                    map.insert("PRIME_NUM".to_string(), Value::from(57));
                    map
                },
                str: {
                    let mut map = Map::new();
                    map.insert("PRIME_STR".to_string(), Value::from("Hello, World!"));
                    map
                },
                define: {
                    let mut map = Map::new();
                    map.insert("PRIME_DEF".to_string(), Value::from("Hello, World!"));
                    map
                },
            }),
        };
        file_contexts.to_toml();
    }

    #[test]
    fn exec_all() {
        let file_contexts = FileContexts::exec_sample();
        let toml_str = file_contexts.to_toml();
        let file_contexts: FileContexts = toml::from_str(&toml_str).unwrap();
        assert_eq!(
            file_contexts.get_filepath(),
            PathBuf::from("arch/exec_sample.svh")
        );

        assert_eq!(file_contexts, FileContexts::exec_sample());
    }

    #[test]
    fn test_all() {
        let file_contexts = FileContexts::test_sample();
        assert_eq!(
            file_contexts.get_filepath(),
            PathBuf::from("include/test_sample.svh")
        );
        let toml_str = file_contexts.to_toml();
        let file_contexts: FileContexts = toml::from_str(&toml_str).unwrap();
        assert_eq!(
            file_contexts.get_filepath(),
            PathBuf::from("include/test_sample.svh")
        );

        assert_eq!(file_contexts, FileContexts::test_sample());
    }
}
