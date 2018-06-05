# Manually Move data from SQL Membership to Identity Core

- After you have created the initial migration in EFCore to create your New Identity Tables, manually call this script to copy your data to new tables then drop your old tables

```CSharp
            migrationBuilder.Sql(File.ReadAllText(Path.Combine(AppContext.BaseDirectory, "Migrations/Scripts/AddIdentity.sql")));
```
