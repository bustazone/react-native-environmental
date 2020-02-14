import * as React from 'react';
import { StyleSheet, View, Text } from 'react-native';
import Config from 'react-native-environmental';

export default function App() {
  return (
    <View style={styles.container}>
      <Text>Config Content: {Config}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
