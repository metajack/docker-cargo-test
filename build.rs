use std::{
    env,
    fs,
    path::PathBuf,
};

fn main() {
    let text = "pub const FOO: u64 = 1024;";
    let out_path = PathBuf::from(env::var("OUT_DIR").unwrap());
    fs::write(out_path.join("foo.rs"), text).unwrap();
}
