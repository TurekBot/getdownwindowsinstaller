package tech.ugma.education.getdown.examples;

import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.BorderPane;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.Stage;

public class MyApp extends Application {
	public static void main(String[] args) {
		launch(args);
	}

	@Override
	public void start(Stage primaryStage) throws Exception {
		BorderPane borderPane = new BorderPane();

		//Make a message
        Text message = new Text("Well, ");
        message.setFont(Font.font("Consolas", 20));
        borderPane.setTop(message);

        //Set up an image
        ImageView helloWorld = new ImageView(new Image("https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/HelloWorld.svg/200px-HelloWorld.svg.png"));
		borderPane.setCenter(helloWorld);

		primaryStage.setTitle("Hello World!");
		primaryStage.setScene(new Scene(borderPane));
		//Display application
		primaryStage.show();
	}
}
