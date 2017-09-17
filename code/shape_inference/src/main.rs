extern crate shape_inference;

#[macro_use]
extern crate serde_json;

fn main() {
    let value = json!([
        {
            "name": "Bob",
            "age": 8
        },
        {
            "name": "Jane",
            "age": 10,
            "address": "Nice Street 3"
        }
    ]);

    let shape = shape_inference::value_to_shape(&value);
    let generated = shape_inference::shape_to_code("Person", &shape);

    if let (type_name, Some(code)) = generated {
        println!("\nType: {}\n\n{}", type_name, code);
    }
}
