  def split_features_by_project
    a = {"id" => "A",  
         "name" => "Project A",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about project A",  
            "$color" => "3366FF",   
            "size" => 0 
            },  
        "children" => []  
        }  
    c = {"id" => "C",  
         "name" => "Project C",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about project C",  
            "$color" => "#F5003D",   
            "size" => 0 
            },  
        "children" => []  
        }  
    f = {"id" => "F",  
         "name" => "Project F",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about project F",  
            "$color" => "#27C200",   
            "size" => 0 
            },  
        "children" => []  
        }  
    p = {"id" => "P",  
         "name" => "Project P",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about project P",  
            "$color" => "#FFFF00",   
            "size" => 0 
            },  
        "children" => []  
        }  
    s = {"id" => "S",  
         "name" => "Project S",  
         "data" => {  
            "$angularWidth" => 0,
            "description" => "some stuff about project S",  
            "$color" => "#9E3DFF",   
            "size" => 0 
            },  
        "children" => []  
        }  

    @records_with_dates.each do |feature|
       data = feature["data"] 
       project = data["project"] 
      if "Project A".eql?project 
        a["data"]["$angularWidth"] += data["timeTaken"]
        a["data"]["size"] += data["timeTaken"] #TODO - avoid repetition     
        children = a["children"]
        feature["data"]["$color"]="#00B8F5"
        children << feature        
     elsif "Project C".eql?project
        c["data"]["$angularWidth"] += data["timeTaken"]
        c["data"]["size"] += data["timeTaken"]      
        children = c["children"]
        feature["data"]["$color"]="#FF0033"
        children << feature        
     elsif "Project F".eql?project
        f["data"]["$angularWidth"] += data["timeTaken"]
        f["data"]["size"] += data["timeTaken"]      
        children = f["children"]
        feature["data"]["$color"]="#88C200"        
        children << feature        
     elsif "Project P".eql?project
        p["data"]["$angularWidth"] += data["timeTaken"]
        p["data"]["size"] += data["timeTaken"]       
        children = p["children"]
        feature["data"]["$color"]="#FFFF3D"
        children << feature        
     elsif "Project S".eql?project
        s["data"]["$angularWidth"] += data["timeTaken"]
        s["data"]["size"] += data["timeTaken"]      
        children = s["children"]
        feature["data"]["$color"]="#BD7AFF"
