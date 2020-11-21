# SafeSyncIoT Dashboard

A potential Server, Database and UI components for my IoT project SafeSync IoT, for a safer, post-covid workspace.

  a. Utilizes [Moor](https://pub.dev/packages/moor) + [SQL](https://pub.dev/packages/sqflite) for a database that works across platforms
  
  b. Utilizes [bloc](https://pub.dev/packages/bloc) + [Provider](https://pub.dev/packages/provider) based State Management Architecture.

## Features

1. Employee Management.
2. Attendance Tracking.
3. Real time (IoT utilized) Logs.
4. Detailed statistics about Employees and their work ethic.

## Screenshots

<table border=3>
<tr>
<th>
<center><b>Real Time Logs:</b></center>
</th>
<th>
<center><b>Employee Safety Statistics:</b></center>
</th>
</tr>

<tr>
<td>

[<img height="450" width="350" src="https://raw.githubusercontent.com/Dhi13man/SafeSyncIoT/main/Screenshots/logs.png" alt="Real Time Logs">](https://raw.githubusercontent.com/Dhi13man/SafeSyncIoT/main/Screenshots/logs.png)
</td>
<td>

[<img height="450" width="350" src="https://raw.githubusercontent.com/Dhi13man/SafeSyncIoT/main/Screenshots/stats.png" alt="Statistics">](https://raw.githubusercontent.com/Dhi13man/SafeSyncIoT/main/Screenshots/stats.png)

</td>
</tr>
</table>

<table border=3>
  <tr>
  <th>
  <center><b>Dynamic Employee information Storage:</b></center>
  </th>
  <th>
  <center><b>Supporting Utilities:</b></center>
  </th>
  </tr>
  <tr>
  <td>

  [<img height="450" width="350" src="https://raw.githubusercontent.com/Dhi13man/SafeSyncIoT/main/Screenshots/employee_view.png" alt="Employee View">](https://raw.githubusercontent.com/Dhi13man/SafeSyncIoT/main/Screenshots/employee_view.png)
  </td>
  <td>

  [<img height="450" width="350" src="https://raw.githubusercontent.com/Dhi13man/SafeSyncIoT/main/Screenshots/sidebarSanitizeScreen.png" alt="Employee View">](https://raw.githubusercontent.com/Dhi13man/SafeSyncIoT/main/Screenshots/sidebarSanitizeScreen.png)
  </td>
  </tr>
</table>

<table border=3>
  <tr>
    <th>
    <center><b>Full Fledged Employee Management System:</b></center>
    </th>
  </tr>
  <tr>
    <td>
<center>

  [<img height="500" width="700" src="https://raw.githubusercontent.com/Dhi13man/SafeSyncIoT/main/Screenshots/employee_management.png" alt="Employee Management">](https://raw.githubusercontent.com/Dhi13man/SafeSyncIoT/main/Screenshots/employee_management.png)
  </center>
  </td>
  </tr>
</table>

### Dependencies Used

1. [material](https://material.io/develop/flutter) for UI

2. [cupertino](https://flutter.dev/docs/development/ui/widgets/cupertino) and [cupertino_icons](https://pub.dev/packages/cupertino_icons) for UI

3. [page_transition](https://pub.dev/packages/page_transition) for page transition animations

4. [moor](https://moor.simonbinder.eu/) and supporting Libraries for Cross Platform SQL Database Handling
    1. [moor2csv](https://pub.dev/packages/moor2csv) for exporting Moor SQL databases to CSV form.
    2. [moor_generator](https://pub.dev/packages/moor_generator) developer dependency that works with moor to turn Table classes from moor into database code

5. [sqflite](https://pub.dev/packages/sqflite) and supporting Libraries for SQL Database
    1. [sqlite3_flutter_libs](https://pub.dev/packages/sqlite3_flutter_libs) helper dependency for sqflite in Flutter
    2. [sqflite_common_ffi](https://pub.dev/packages/sqflite_common_ffi) developer dependency that provides SQL ffi File handling capability to desktop platform

6. [undo](https://pub.dev/packages/undo) for facilitating Moor based SQL database through bloc State Management

7. [bloc](https://pub.dev/packages/bloc) and [flutter_bloc](https://pub.dev/packages/flutter_bloc) for State Management

8. [provider](https://pub.dev/packages/provider) for less intensive State Management

9. [path_provider](https://pub.dev/packages/path_provider) for File Handling

10. [permission_handler](https://pub.dev/packages/permission_handler) *(only required to build for mobile devices)*

11. [url_launcher](https://pub.dev/packages/url_launcher) for launching URLs, including `mailto:` links

12. [build_runner](https://pub.dev/packages/build_runner) developer dependency for building Moor database tables

13. [build_web_compilers](https://pub.dev/packages/build_web_compilers) used as a development dependency for users of `package:build` who want to run code in a browser (Flutter Web)
