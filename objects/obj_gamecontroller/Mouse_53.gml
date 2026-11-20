/// Bulldoze Buildings 

if (bulldoze_mode)
{
    // Buildings that can currently be bulldozed
    var building_types = [
        O_Home,
        O_Park,
        O_Hospital,
        O_Center
    ];

    // Check each building type
    for (var i = 0; i < array_length(building_types); i++)
    {
        var target = instance_position(
            mouse_x,
            mouse_y,
            building_types[i]
        );

        // Only destroy buildings that have been placed
        if (target != noone && target.is_placed)
        {
            // Reverse the building's statistics
            switch (target.object_index)
            {
                case O_Home:
                    global.Beans -= 2;
                    global.Purpose += 2;
                    global.Recreation += 2;
                    global.Health += 2;
                break;

                case O_Park:
                    global.Recreation -= 20;
                break;

                case O_Hospital:
                    global.Health -= 16;
                    global.Purpose -= 6;
                break;

                case O_Center:
                    global.Purpose -= 20;
                    global.Beans += 20;
                break;
            }

            // Destroy the selected building
            with (target)
            {
                instance_destroy();
            }

            // Stop checking after destroying one building
            break;
        }
    }
}